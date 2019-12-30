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
		
		let cats = [
			CatProfile(name: "Барсик", age: 3, breed: .maineCoon, photoName: "Cat_Barsik", description: "Люблю драть мебель, и мяукать по ночам. Также очень люблю, когда мне чешут животик."),
			CatProfile(name: "Маруся", age: 2, breed: .norwegianForestCat, photoName: "Cat_Marusia", description: "Люблю с умным видом смотреть в окно, ожидая конца света.")
		]
		
		let cardsStackView = CardsStackView()
		cats.forEach { cat in
			let cardViewModel = CardView.ViewModel(imageName: cat.photoName, headerText: "\(cat.name), \(cat.age)", titleText: cat.breed.name, subtitleText: cat.description)

			let cardView = CardView(model: cardViewModel)
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
