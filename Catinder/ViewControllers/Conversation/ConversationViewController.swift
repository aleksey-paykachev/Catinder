//
//  ConversationViewController.swift
//  Catinder
//
//  Created by Aleksey on 24/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ConversationViewController: UICollectionViewController {
	// MARK: - Properties
	
	private let dataManager: DataManager
	
	private let collectionViewFlowLayout = ConversationViewControllerFlowLayout()
	private let cellReuseId = "ConversationMessageCell"
	private let textInputAccessoryView = CatinderTextInputAccessoryView()
	private let navigationItemCollocutorButton = CatinderCircleBarButtonItem()

	private let viewModel: ConversationViewModel
	private var messages: [ConversationMessageViewModel] = []
	
	
	// MARK: - Init
	
	init(viewModel: ConversationViewModel, dataManager: DataManager = .shared) {
		self.dataManager = dataManager
		self.viewModel = viewModel
		super.init(collectionViewLayout: collectionViewFlowLayout)
		
		setupNavigationBar()
		setupCollectionViewLayout()
		setupCollectionView()
		setupSubviews()
		setupGestures()
		
		loadMessages()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupNavigationBar() {
		title = viewModel.collocutorName
		
		navigationItem.rightBarButtonItem = navigationItemCollocutorButton
		navigationItemCollocutorButton.set(imageName: viewModel.collocutorImageName)
		
		navigationItemCollocutorButton.onClick { [weak self] in
			self?.showProfileViewer()
		}
	}
	
	private func setupCollectionViewLayout() {
		collectionViewFlowLayout.scrollDirection = .vertical
		let cellMaxWidth = collectionView.bounds.width
		collectionViewFlowLayout.estimatedItemSize = CGSize(width: cellMaxWidth, height: 0)
	}
	
	private func setupCollectionView() {
		collectionView.backgroundColor = .lightGray
		collectionView.alwaysBounceVertical = true
		collectionView.contentInset.top = 10

		collectionView.register(ConversationMessageCell.self, forCellWithReuseIdentifier: cellReuseId)
	}
	
	private func setupSubviews() {
		textInputAccessoryView.delegate = self
	}
	
	private func setupGestures() {
		// hide keyboard on tap
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		view.addGestureRecognizer(tapGestureRecognizer)
	}
	
	private func showProfileViewer() {
		loadCollocutorProfile { [weak self] profile in
			self?.present(ProfileViewerViewController(viewModel: profile.profileViewModel), animated: true)
		}
	}
	
	override var inputAccessoryView: UIView? {
		textInputAccessoryView
	}
	
	override var canBecomeFirstResponder: Bool {
		true
	}
	
	
	// MARK: - Load data
	
	private func loadMessages() {
		showLoadingIndicator()
		
		dataManager.getMessages(forConversationWith: "Current-Collocutor-UID") { [weak self] messages, error in
			guard let self = self else { return }

			self.hideLoadingIndicator()

			if let error = error {
				print(error.localizedDescription)
				return
			}
			
			self.messages = messages?.compactMap { $0.conversationMessageViewModel } ?? []
			self.collectionView.reloadData()
		}
	}
	
	private func loadCollocutorProfile(completion: @escaping (Profile) -> Void) {
		showLoadingIndicator()
		
		dataManager.getProfile(by: viewModel.collocutorUid) { [weak self] profile, error in
			guard let self = self else { return }
			
			self.hideLoadingIndicator()

			if let error = error {
				print(error.localizedDescription)
				return
			}

			if let profile = profile {
				completion(profile)
			}
		}
	}
	
	
	// MARK: - Methods
	
	private func addMessage(text: String) {
		let sender = Bool.random() ? ConversationMessageViewModel.Sender.user : .collocutor

		let message = ConversationMessageViewModel(sender: sender, messageText: text)
		messages.append(message)
		let newItemIndexPath = IndexPath(item: messages.endIndex - 1, section: 0)
		collectionView.insertItems(at: [newItemIndexPath])
		
		#warning("Set 'sended' status for sended messages.")
		dataManager.addMessage(forConversationWith: "")
	}
	
	@objc private func hideKeyboard() {
		textInputAccessoryView.hideKeyboard()
	}
}


// MARK: - UICollectionViewDataSource

extension ConversationViewController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		messages.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! ConversationMessageCell
		cell.viewModel = messages[indexPath.item]
		
		return cell
	}
}


// MARK: - CatinderTextInputAccessoryViewDelegate

extension ConversationViewController: CatinderTextInputAccessoryViewDelegate {
	func sendButtonDidTapped(with text: String) {
		addMessage(text: text)
	}
}
