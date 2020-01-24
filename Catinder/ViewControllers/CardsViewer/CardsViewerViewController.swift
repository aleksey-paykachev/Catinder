//
//  CardsViewerViewController.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CardsViewerViewController: UIViewController {

	private let dataManager: DataManager
	private let cardsStackView = CardsStackView()
	
	init(dataManager: DataManager = .shared) {
		self.dataManager = dataManager
		super.init(nibName: nil, bundle: nil)
		
		setupView()
		loadData()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		view.backgroundColor = .white
		
		// top menu
		let topMenuView = TopMenuView()
		topMenuView.delegate = self
		
		// cards stack
		cardsStackView.delegate = self
		
		// bottom menu
		let bottomMenuView = BottomMenuView()
		bottomMenuView.delegate = self
		
		// main stack
		let subviews = [topMenuView, cardsStackView, bottomMenuView]
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.axis = .vertical
		stackView.spacing = 12
		
		view.addSubview(stackView)
		stackView.constrainToSuperview(paddings: .vertical(6) + .horizontal(12))
	}
	
	private func loadData() {
		dataManager.getAllProfiles { (profiles, error) in
			if let error = error {
				print(error.localizedDescription)
				return
			}

			let cardViewModelRepresentables = profiles as? [CardViewModelRepresentable] ?? []
			cardsStackView.add(cardViewModelRepresentables)
		}
	}
	
	private func showMatchSplashScreen() {
		let matchViewModel = MatchViewModel(userProfileImageName: "Cat_Bob_2", matchedProfileName: "Маруся", matchedProfileImageName: "Cat_Marusia")
		let matchSplashScreenViewController = MatchSplashScreenViewController(viewModel: matchViewModel)
		addChild(matchSplashScreenViewController)
		view.addSubview(matchSplashScreenViewController.view)
	}
}


// MARK: - TopMenuActionsDelegate

extension CardsViewerViewController: TopMenuActionsDelegate {
	func profileButtonDidPressed() {
		let profileEditorViewController = ProfileEditorViewController()
		navigationController?.pushViewController(profileEditorViewController, animated: true)
	}
	
	func messagesButtonDidPressed() {
		let lastMessagesViewController = LastMessagesViewController()
		navigationController?.pushViewController(lastMessagesViewController, animated: true)
	}
}


// MARK: - BotomMenuActionsDelegate

extension CardsViewerViewController: BotomMenuActionsDelegate {
	func undoButtonDidPressed() {
		cardsStackView.undoLastRemoval()
	}
	
	func dislikeButtonDidPressed() {
		cardsStackView.removeTopCard(decision: .dislike)
	}
	
	func likeButtonDidPressed() {
		cardsStackView.removeTopCard(decision: .like(type: .regular))
	}
	
	func superLikeButtonDidPressed() {
		cardsStackView.removeTopCard(decision: .like(type: .super))
	}
}


// MARK: - CardsStackViewDelegate

extension CardsViewerViewController: CardsStackViewDelegate {
	
	func showMoreInfoButtonDidPressed(for cardId: String) {
		dataManager.getProfile(by: cardId) { profile, error in
			if let error = error {
				print(error.localizedDescription)
				return
			}
			
			guard let profileViewModel = (profile as? ProfileViewModelRepresentable)?.profileViewModel else { return }

			let profileViewerViewController = ProfileViewerViewController(viewModel: profileViewModel)
			present(profileViewerViewController, animated: true)
		}
	}
	
	func cardDidSwiped(cardId: String, decision: RelationshipDecision) {
		
		switch decision {
		case .dislike:
			dataManager.setDislike(to: cardId) { error in
				if let error = error {
					print("Error:", error.localizedDescription)
				}
			}
		case .like(let type):
			print("Like type:", type)
			#warning("Use single method for like and superLike")
			dataManager.setLike(to: cardId) { isLikeMutual, error in
				if let error = error {
					print("Eror:", error.localizedDescription)
					return
				}
				
				if isLikeMutual == true {
					cardsStackView.cancelAllUserInteractions()
					showMatchSplashScreen()
				}
			}
		}
	}
}
