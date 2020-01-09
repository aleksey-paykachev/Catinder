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
	
	init(dataManager: DataManager = DataManager.shared) {
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
		
		// bottom menu
		let bottomMenuView = BottomMenuView()
		bottomMenuView.delegate = cardsStackView
		
		// main stack
		let subviews = [topMenuView, cardsStackView, bottomMenuView]
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.axis = .vertical
		stackView.spacing = 12
		
		view.addSubview(stackView)
		stackView.constraintToSuperview(insets: UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
	}
	
	private func loadData() {
		dataManager.getAllProfiles { (profiles, error) in
			if let error = error {
				print(error.localizedDescription)
				return
			}

			let cardViewModels = profiles as? [CardViewModelRepresentable] ?? []
			updateCardsStackView(with: cardViewModels)
		}
	}
	
	private func updateCardsStackView(with cardViewModels: [CardViewModelRepresentable]) {
		cardViewModels.forEach { cardViewModelObject in
			let cardView = CardView(viewModel: cardViewModelObject.viewModel)
			cardsStackView.add(cardView)
		}
	}
}
