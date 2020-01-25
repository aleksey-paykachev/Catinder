//
//  LastMessagesViewController.swift
//  Catinder
//
//  Created by Aleksey on 22/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class LastMessagesViewController: UICollectionViewController {
	
	private let cellReuseId = "LastMessageCell"
	private var lastMessages: [LastMessageViewModel] = []
	
	// MARK: - Init
	
	init() {
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
		
		setupNavigationBar()
		setupCollectionView()
		
		// del - demo messages
		lastMessages = [
			LastMessageViewModel(profileName: "Маруся", profileImageName: "Cat_Marusia", message: "Привет."),
			LastMessageViewModel(profileName: "Мамочка", profileImageName: "Cat_Stray", message: "Пойдёшь со мной на дело? Надо у фраера одного скатерку спереть."),
			LastMessageViewModel(profileName: "Дружок", profileImageName: "Dog_Druzhok", message: "Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!")
		]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupNavigationBar() {
		title = "Последние сообщения"
	}
	
	private func setupCollectionView() {
		collectionView.backgroundColor = .white
		collectionView.alwaysBounceVertical = true

		collectionView.register(LastMessageCell.self, forCellWithReuseIdentifier: cellReuseId)
	}
}


// MARK: - UICollectionViewDataSource

extension LastMessagesViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return lastMessages.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! LastMessageCell
		cell.viewModel = lastMessages[indexPath.item]

		return cell
	}
}


// MARK: - UICollectionViewDelegate

extension LastMessagesViewController {
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let message = lastMessages[indexPath.item]

		let conversationViewModel = ConversationViewModel(collocutorName: message.profileName, collocutorImageName: message.profileImageName)
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

		return CGSize(width: collectionView.bounds.width * 0.96, height: 90)
	}
}
