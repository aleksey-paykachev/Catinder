//
//  CardView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CardView: UIView {
	private let imageView = UIImageView()
	private let informationLabel = UILabel()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(model: CardViewModel) {
		super.init(frame: .zero)
		
		setupView()
		updateUI(using: model)
	}
	
	private func setupView() {
		// image
		addSubview(imageView)
		imageView.constraintToSuperview()

		imageView.contentMode = .scaleAspectFill
		
		// label
		addSubview(informationLabel)
		informationLabel.constraintToSuperview()

		informationLabel.numberOfLines = 0
		informationLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
		informationLabel.textColor = .white
		informationLabel.shadowColor = UIColor.init(white: 0.5, alpha: 0.5)
		informationLabel.shadowOffset = CGSize(width: 1, height: 1)
	}
	
	private func updateUI(using model: CardViewModel) {
		imageView.image = UIImage(named: model.imageName)
		informationLabel.text = model.informationText
	}
}

struct CardViewModel {
	let imageName: String
	let informationText: String
}

struct Cat {
	let name: String
	let age: Int
	let breed: CatBreed
	let photoName: String
}

enum CatBreed: String {
	case maineCoon = "Мейн-кун"
	case norwegianForestCat = "Норвежская лесная кошка"
	
	var name: String {
		return rawValue
	}
}
