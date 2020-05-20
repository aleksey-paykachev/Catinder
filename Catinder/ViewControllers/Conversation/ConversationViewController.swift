//
//  ConversationViewController.swift
//  Catinder
//
//  Created by Aleksey on 24/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
	// MARK: - Properties
	
	private let dataManager: DataManager
	private let authManager: AuthenticationManager
	
	private let tableView = UITableView()
	private let navigationItemCollocutorButton = CatinderCircleBarButtonItem()
	private let textInputView = ConversationTextInputView()
	private var textInputViewBottomConstraint: NSLayoutConstraint!

	private let viewModel: ConversationViewModel
	private var messages: [Message] = []
	
	
	// MARK: - Init
	
	init(viewModel: ConversationViewModel, dataManager: DataManager = .shared, authManager: AuthenticationManager = .shared) {
		self.dataManager = dataManager
		self.authManager = authManager
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		setupNavigationBar()
		setupView()
		setupTableView()
		setupTextInputView()
		setupGestures()
		
		loadMessages()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupNavigationBar() {
		title = viewModel.collocutorName
		
		// setup collocutor button inside navigation bar
		navigationItem.rightBarButtonItem = navigationItemCollocutorButton
		dataManager.getImage(name: viewModel.collocutorImageName) { [weak self] result in
			if case Result.success(let image) = result {
				self?.navigationItemCollocutorButton.set(image: image)
			}
		}
		
		navigationItemCollocutorButton.onClick { [weak self] in
			self?.showProfileViewer()
		}
	}
	
	private func setupView() {
		view.backgroundColor = .background
	}
		
	private func setupTableView() {
		view.addSubview(tableView)
		tableView.constrainToSuperview(anchors: [.leading, .trailing, .top], respectSafeArea: false)

		tableView.backgroundColor = .conversationBackground
		tableView.alwaysBounceVertical = true
		tableView.allowsSelection = false
		tableView.scrollsToTop = false
		tableView.separatorStyle = .none
		tableView.dataSource = self
		
		tableView.register(ConversationMessageCell.self, forCellReuseIdentifier: "ConversationMessageCell")
	}
	
	private func setupTextInputView() {
		view.addSubview(textInputView)
		textInputView.constrainToSuperview(anchors: [.leading ,.trailing])

		textInputViewBottomConstraint = textInputView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		textInputViewBottomConstraint.isActive = true
		textInputView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
		
		textInputView.delegate = self
	}
	
	private func setupGestures() {
		// hide keyboard on tap
		let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tapGesture)
	}
	
	private func showProfileViewer() {
		loadCollocutorProfile { [weak self] profile in
			self?.present(ProfileViewerViewController(viewModel: profile.profileViewModel), animated: true)
		}
	}
	
	
	// MARK: - Load data
	
	private func loadMessages() {
		showActivityIndicator()
		
		dataManager.getMessages(forConversationWith: viewModel.collocutorUid) { [weak self] result in
			guard let self = self else { return }

			self.hideActivityIndicator()

			switch result {
			case .failure(let error):
				self.showNotification(error.localizedDescription)

			case .success(let messages):
				break
			}
			
			let testMessages = [Message(date: Date(), senderUid: "", receiverUid: "", text: "Preved"), Message(date: Date(), senderUid: "", receiverUid: "", text: "Medved")]
			self.messages = testMessages
			self.tableView.reloadData()
		}
	}
	
	private func loadCollocutorProfile(completion: @escaping (Profile) -> Void) {
		showActivityIndicator()
		
		dataManager.getProfile(by: viewModel.collocutorUid) { [weak self] result in
			guard let self = self else { return }
			
			self.hideActivityIndicator()

			switch result {
			case .failure(let error):
				self.showNotification(error.localizedDescription)

			case .success(let profile):
				completion(profile)
			}
		}
	}
	
	
	// MARK: - Methods
	
	private func addMessage(text: String) {
		guard let userUid = authManager.loggedInUser?.uid else { return }

		// add message localy
		let message = Message(date: Date(), senderUid: userUid, receiverUid: viewModel.collocutorUid, text: text)
		messages.append(message)

		// update tableView
		let newItemIndexPath = IndexPath(item: messages.endIndex - 1, section: 0)
		tableView.performBatchUpdates({
			tableView.insertRows(at: [newItemIndexPath], with: .bottom)
		})
		
		// add message to server
		dataManager.addMessage(forConversationWith: viewModel.collocutorUid) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .failure(let error):
				self.showNotification(error.localizedDescription)

			case .success:
				print("Sended")
				// indicate successeful message sending
				#warning("Add mark sign to sended messages")
			}
		}
	}
}


// MARK: - UITableViewDataSource

extension ConversationViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		messages.count
	}
		
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationMessageCell", for: indexPath) as! ConversationMessageCell
		cell.viewModel = messages[indexPath.item].conversationMessageViewModel
		
		return cell
	}
}


// MARK: - Keyboard handling

extension ConversationViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// add keyboard notification observers
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		// remove keyboard notification observers
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc private func handleKeyboardWillShow(notification: Notification) {
		guard let keyboardInfo = KeyboardNotificationInfo(of: notification) else { return }
		
		setContentYOffset(-keyboardInfo.height, with: keyboardInfo.animationDuration)
	}
	
	@objc private func handleKeyboardWillHide(notification: Notification) {
		guard let keyboardInfo = KeyboardNotificationInfo(of: notification) else { return }

		setContentYOffset(0, with: keyboardInfo.animationDuration)
	}
	
	private func setContentYOffset(_ offsetY: CGFloat, with animationDuration: TimeInterval) {

		textInputViewBottomConstraint.constant = offsetY
		UIView.animate(withDuration: animationDuration) {
			self.view.layoutIfNeeded()
		}
	}
}


// MARK: - ConversationTextInputViewDelegate

extension ConversationViewController: ConversationTextInputViewDelegate {
	func sendButtonDidTapped(with text: String) {
		addMessage(text: text)

		let lastIndexPath = IndexPath(item: messages.count - 1, section: 0)
		tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
	}
}
