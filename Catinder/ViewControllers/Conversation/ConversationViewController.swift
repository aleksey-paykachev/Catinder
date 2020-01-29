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
