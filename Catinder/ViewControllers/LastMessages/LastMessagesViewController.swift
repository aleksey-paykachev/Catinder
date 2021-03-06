//
//  LastMessagesViewController.swift
//  Catinder
//
//  Created by Aleksey on 22/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class LastMessagesViewController: UICollectionViewController {
	// MARK: - Properties
	
	private let dataManager: DataManager
	private var lastMessages: [LastMessageViewModel] = []

	
	// MARK: - Init
	
	init(dataManager: DataManager = .shared) {
		self.dataManager = dataManager
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
		
		setupNavigationBar()
		setupCollectionView()
		
		loadData()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupNavigationBar() {
		title = "Последние сообщения"
	}
	
	private func setupCollectionView() {
		collectionView.backgroundColor = .background
		collectionView.alwaysBounceVertical = true
		collectionView.contentInset.top = 24

		collectionView.registerCell(LastMessageCell.self)
	}
	
	
	// MARK: - Load data
	
	private func loadData() {
		showActivityIndicator()
		
		dataManager.getMatches { [weak self] result in
			guard let self = self else { return }

			self.hideActivityIndicator()

			switch result {
			case .failure(let error):
				self.showNotification(error.localizedDescription)

			case .success(let matches):
				self.lastMessages = matches.map { $0.lastMessageViewModel }
				self.collectionView.reloadData()
			}
		}
	}
}


// MARK: - UICollectionViewDataSource

extension LastMessagesViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return lastMessages.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueCell(LastMessageCell.self, for: indexPath)
		cell.viewModel = lastMessages[indexPath.item]

		return cell
	}
}


// MARK: - UICollectionViewDelegate

extension LastMessagesViewController {
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let message = lastMessages[indexPath.item]

		let conversationViewModel = ConversationViewModel(collocutorUid: message.profileUid, collocutorName: message.profileName, collocutorImageName: message.profileImageName)
		let conversationViewController = ConversationViewController(viewModel: conversationViewModel)
		navigationController?.pushViewController(conversationViewController, animated: true)
	}
}


// MARK: - UICollectionViewDelegateFlowLayout

extension LastMessagesViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

		return 16
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		return CGSize(width: collectionView.bounds.width * 0.96, height: 80)
	}
}
