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
		bottomMenuView.delegate = cardsStackView
		
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
}


// MARK: - TopMenuActionsDelegate

extension CardsViewerViewController: TopMenuActionsDelegate {
	func profileButtonDidPressed() {
		let profileViewController = ProfileEditorNavigationController()
		present(profileViewController, animated: true)
	}
	
	func messagesButtonDidPressed() {
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
}
