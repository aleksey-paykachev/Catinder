//
//  CardsViewerViewController.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CardsViewerViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let cardViewModelObjects: [CardViewModelRepresentable] = [
			CatProfile(name: "Барсик", age: 3, breed: .maineCoon, photosNames: ["Cat_Barsik"], description: "Люблю драть мебель, и мяукать по ночам. Также очень люблю, когда мне чешут животик."),
			DogProfile(name: "Дружок", photoName: "Dog_Druzhok", description: "Люблю убивать людей."),
			CatProfile(name: "Маруся", age: 2, breed: .norwegianForestCat, photosNames: ["Cat_Marusia"], description: "Люблю с умным видом смотреть в окно, ожидая конца света.")
		]
		
		let cardsStackView = CardsStackView()
		cardViewModelObjects.forEach { cardViewModelObject in
			let cardView = CardView(model: cardViewModelObject.viewModel)
			cardsStackView.add(cardView)
		}

		let subviews = [TopMenuView(), cardsStackView, BottomMenuView()]
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.axis = .vertical

		// layout
		view.addSubview(stackView)
		stackView.constraintToSuperview()
	}
}
