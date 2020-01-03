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
			CatProfile(name: "Маруся", age: 2, breed: .norwegianForestCat, photosNames: ["Cat_Marusia"], description: "Люблю с умным видом смотреть в окно, ожидая конца света."),
			CatProfile(name: "Боб", age: 10, breed: .unknown, photosNames: ["Cat_Bob_1", "Cat_Bob_2", "Cat_Bob_3"], description: "Про меня сняли фильм, и написали несколько книг. А чего добился ты?")
		]
		
		let cardsStackView = CardsStackView()
		cardViewModelObjects.forEach { cardViewModelObject in
			let cardView = CardView(viewModel: cardViewModelObject.viewModel)
			cardsStackView.add(cardView)
		}

		let subviews = [TopMenuView(), cardsStackView, BottomMenuView()]
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.axis = .vertical
		stackView.spacing = 12

		view.addSubview(stackView)
		stackView.constraintToSuperview(insets: UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
	}
}
