//
//  CardsStackView.swift
//  Catinder
//
//  Created by Aleksey on 30/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CardsStackView: UIView {
	private var cardViews: [CardView] = []
	
	func add(_ cardView: CardView) {
		cardViews.append(cardView)
		
		addSubview(cardView)
		cardView.constraintToSuperview()
	}
}
