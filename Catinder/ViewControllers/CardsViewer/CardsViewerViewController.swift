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
	private var profiles: [Profile] = []

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
		view.backgroundColor = .background
		
		// top menu
		let topMenuView = TopMenuView()
		topMenuView.delegate = self
		
		// cards stack
		cardsStackView.delegate = self
		
		// bottom menu
		let bottomMenuView = BottomMenuView()
		bottomMenuView.delegate = self
		
		// main stack
		let stackView = VStackView([topMenuView, cardsStackView, bottomMenuView], spacing: 12)
		view.addSubview(stackView)
		stackView.constrainToSuperview(paddings: .vertical(6) + .horizontal(12))
	}
	
	private func loadData() {
		showActivityIndicator()
		
		dataManager.getAllProfiles { [weak self] profiles, error in
			guard let self = self else { return }

			self.hideActivityIndicator()
			
			if let error = error {
				self.showError(error.localizedDescription)
				return
			}

			self.profiles = profiles ?? []
			self.cardsStackView.add(profiles ?? [])
		}
	}
		
	private func showMatchSplashScreen(for profileId: String) {
		// Prevent multiple splash screen appearance.
		guard !(children.last is MatchSplashScreenViewController) else { return }
		guard let matchedProfile = profiles.first(where: { $0.uid == profileId }) else { return }

		let matchViewModel = MatchViewModel(matchedProfileUid: matchedProfile.uid,
											matchedProfileName: matchedProfile.name,
											matchedProfileImageName: matchedProfile.photoName)
		let matchSplashScreenVC = MatchSplashScreenViewController(viewModel: matchViewModel)
		
		addChild(matchSplashScreenVC)
		view.addSubview(matchSplashScreenVC.view)
	}

	
	// MARK: - View lifecycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
}


// MARK: - TopMenuActionsDelegate

extension CardsViewerViewController: TopMenuActionsDelegate {
	func profileButtonDidPressed() {
		let profileEditorVC = ProfileEditorViewController()
		navigationController?.pushViewController(profileEditorVC, animated: true)
	}
	
	func messagesButtonDidPressed() {
		let lastMessagesVC = LastMessagesViewController()
		navigationController?.pushViewController(lastMessagesVC, animated: true)
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
		guard let profile = profiles.first(where: { $0.uid == cardId }) else { return }
		
		let profileViewerVC = ProfileViewerViewController(viewModel: profile.profileViewModel)
		present(profileViewerVC, animated: true)
	}
	
	func cardDidSwiped(cardId: String, decision: RelationshipDecision) {
		switch decision {
		case .dislike:
			dataManager.setDislike(to: cardId) { [weak self] error in
				if let error = error {
					self?.showError(error.localizedDescription)
				}
			}
			
		case .like(let type):
			dataManager.setLike(to: cardId, likeType: type) { [weak self] isLikeMutual, error in
				if let error = error {
					self?.showError(error.localizedDescription)
					return
				}
				
				if isLikeMutual == true {
					self?.cardsStackView.cancelAllUserInteractions()
					self?.showMatchSplashScreen(for: cardId)
				}
			}
		}
	}
}
