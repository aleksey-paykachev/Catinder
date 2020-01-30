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
	
	private let collectionViewFlowLayout = UICollectionViewFlowLayout()
	private let cellReuseId = "ConversationMessageCell"
	private let newMessageTextField = UITextField()

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
		setupNewMessageTextField()
		
		loadData()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupNavigationBar() {
		title = viewModel.collocutorName
		
		guard let catinderNavigationBar = (navigationController as? CatinderNavigationController)?.catinderNavigationBar else { return }
		
		#warning("Set collocutor image in navigation bar.")
	}
	
	private func setupCollectionViewLayout() {
		collectionViewFlowLayout.scrollDirection = .horizontal
		let cellMaxWidth = collectionView.bounds.width
		collectionViewFlowLayout.estimatedItemSize = CGSize(width: cellMaxWidth, height: 0)
	}
	
	private func setupCollectionView() {
		collectionView.backgroundColor = .lightGray
		collectionView.alwaysBounceVertical = true
		collectionView.register(ConversationMessageCell.self, forCellWithReuseIdentifier: cellReuseId)
	}
	
	private func setupNewMessageTextField() {
		newMessageTextField.backgroundColor = .red
		newMessageTextField.delegate = self
		
		view.addSubview(newMessageTextField)
		newMessageTextField.constrainToSuperview(anchors: [.leading, .trailing, .bottom], respectSafeArea: false)
	}
	
	
	// MARK: - Load data
	
	func loadData() {
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
	
	
	// MARK: - Methods
	
	func addMessage(text: String) {
		let sender = Bool.random() ? ConversationMessageViewModel.Sender.user : .collocutor

		let message = ConversationMessageViewModel(sender: sender, messageText: text)
		messages.append(message)
		let newItemIndexPath = IndexPath(item: messages.endIndex - 1, section: 0)
		collectionView.insertItems(at: [newItemIndexPath])
		
		#warning("Set 'sended' status for sended messages.")
		dataManager.addMessage(forConversationWith: "")
	}
}


// MARK: - UICollectionViewDataSource

extension ConversationViewController {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return messages.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! ConversationMessageCell
		cell.viewModel = messages[indexPath.item]
		
		return cell
	}
}


// MARK: - UITextFieldDelegate

extension ConversationViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let textMessage = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), textMessage.isNotEmpty else { return false }

		addMessage(text: textMessage)

		textField.text = ""
		return true
	}
}
