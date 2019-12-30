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
			Cat(name: "Барсик", age: 3, breed: .maineCoon, photoName: "Cat_Barsik"),
			Cat(name: "Маруся", age: 2, breed: .norwegianForestCat, photoName: "Cat_Marusia")
		]
		
		let cardsStackView = CardsStackView()
		cats.forEach { cat in
			let catInformationText = "\(cat.name), \(cat.age)\n\(cat.breed.name)"
			let cardViewModel = CardView.ViewModel(imageName: cat.photoName, informationText: catInformationText)

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
