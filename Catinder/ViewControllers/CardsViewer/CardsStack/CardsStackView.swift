//
//  CardsStackView.swift
//  Catinder
//
//  Created by Aleksey on 30/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CardsStackViewDelegate: class {
	func showMoreInfoButtonDidPressed(for cardId: String)
}

class CardsStackView: UIView {
	weak var delegate: CardsStackViewDelegate?
	private var cardViews: [CardView] = []
	
	private var topCard: CardView? {
		return cardViews.last
	}
	
	func add(_ cardView: CardView) {
		layer.zPosition = 1 // place CardsStackView above all other views

		cardView.delegate = self
		cardViews.append(cardView)
		
		addSubview(cardView)
		cardView.constraintToSuperview()
	}
}


extension CardsStackView: BotomMenuActionsDelegate {
	func likeButtonDidPressed() {
		topCard?.remove(direction: .right)
	}
	
	func dislikeButtonDidPressed() {
		topCard?.remove(direction: .left)
	}
}


extension CardsStackView: CardViewDelegate {
	func cardDidSwiped(_ cardView: CardView, direction: CardView.SwipeDirection) {
		// there is possibility that removing card would not be on top of stack
		cardViews.removeAll { $0 === cardView }
		cardView.removeFromSuperview()
	}
	
	func showMoreInfoButtonDidPressed(for cardId: String) {
		delegate?.showMoreInfoButtonDidPressed(for: cardId)
		print("Show more info for", cardId)
	}
}
