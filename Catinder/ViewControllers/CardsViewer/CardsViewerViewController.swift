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
		
		let cat = Cat(name: "Барсик", age: 3, breed: .maineCoon, photoName: "Cat_Maine_Coon")
		let catInformationText = "\(cat.name), \(cat.age)\n\(cat.breed.name)"
		let cardViewModel = CardView.ViewModel(imageName: cat.photoName, informationText: catInformationText)

		let subviews = [TopMenuView(), CardView(model: cardViewModel), BottomMenuView()]
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.axis = .vertical

		// layout
		view.addSubview(stackView)
		stackView.constraintToSuperview()
	}
}
