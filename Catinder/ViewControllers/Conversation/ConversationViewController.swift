//
//  ConversationViewController.swift
//  Catinder
//
//  Created by Aleksey on 24/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

struct ConversationMessageViewModel {
	let sender: Sender
	let message: String
	
	enum Sender {
		case user
		case collocutor
	}
}

struct ConversationViewModel {
	let collocutorName: String
	let collocutorImageName: String
}

class ConversationViewController: UICollectionViewController {
	
	// MARK: - Properties
	
	private let collectionViewFlowLayout = UICollectionViewFlowLayout()
	private let cellReuseId = "ConversationMessageCell"

	private let viewModel: ConversationViewModel
	private var messages: [ConversationMessageViewModel] = []
	
	
	// MARK: - Init
	
	init(viewModel: ConversationViewModel) {
		self.viewModel = viewModel
		super.init(collectionViewLayout: collectionViewFlowLayout)
		
		setupNavigationBar()
		setupCollectionViewLayout()
		setupCollectionView()
		
		// del - demo conversation messages
		messages = [
			ConversationMessageViewModel(sender: .collocutor, message: "Привет."),
			ConversationMessageViewModel(sender: .user, message: "Привет, привет.\nКак у тебя дела?"),
			ConversationMessageViewModel(sender: .collocutor, message: "Да вот, решил написать тебе длинное сообщение, чтобы проверить, будет ли оно переноситься на следующую строку, чтобы целиком влезть на экран.")
		]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupNavigationBar() {
		title = viewModel.collocutorName
		
		guard let catinderNavigationBar = (navigationController as? MainNavigationController)?.catinderNavigationBar else { return }
		
		#warning("Set collocutor image in navigation bar.")
	}
	
	private func setupCollectionViewLayout() {
		collectionViewFlowLayout.scrollDirection = .horizontal
		let cellMaxWidth = collectionView.bounds.width
		collectionViewFlowLayout.estimatedItemSize = CGSize(width: cellMaxWidth, height: 0)
	}
	
	private func setupCollectionView() {
		collectionView.backgroundColor = .white
		collectionView.alwaysBounceVertical = true
		collectionView.register(ConversationMessageCell.self, forCellWithReuseIdentifier: cellReuseId)
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
