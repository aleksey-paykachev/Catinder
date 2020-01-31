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

	private let viewModel: ConversationViewModel
	private var messages: [ConversationMessageViewModel] = []
	
	#warning("Move to separate class")
	lazy var textInputView: UIView = {
		let textInputView = UIView()
		textInputView.frame.size.height = 50
		textInputView.backgroundColor = .white
		textInputView.layer.setShadow(size: 1, offsetY: -1, alpha: 0.1)
		
		// text view
		let newMessageTextView = UITextView()
		newMessageTextView.isScrollEnabled = false
		newMessageTextView.clipsToBounds = false
		newMessageTextView.layer.setShadow(size: 2, alpha: 0.2)

		// send button
		let sendButton = UIButton(type: .system)
		#warning("Add real send button image.")
		sendButton.setTitle(">", for: .normal)
		sendButton.constrainWidth(to: 20)
		
		// stack
		let stack = HorizontalStackView([newMessageTextView, sendButton], spacing: 10)
		textInputView.addSubview(stack)
		stack.constrainToSuperview(paddings: .all(10), respectSafeArea: false)

		return textInputView
	}()
	
	
	// MARK: - Init
	
	init(viewModel: ConversationViewModel, dataManager: DataManager = .shared) {
		self.dataManager = dataManager
		self.viewModel = viewModel
		super.init(collectionViewLayout: collectionViewFlowLayout)
		
		setupNavigationBar()
		setupCollectionViewLayout()
		setupCollectionView()
		
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
		
		// hide keyboard on tap
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		view.addGestureRecognizer(tapGestureRecognizer)
	}
	
	override var inputAccessoryView: UIView? {
		textInputView
	}
	
	override var canBecomeFirstResponder: Bool {
		true
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
		print("Hide keyboard")
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
