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
	func cardDidSwiped(cardId: String, decision: RelationshipDecision)
}

class CardsStackView: UIView {
	// MARK: - Properties
	
	weak var delegate: CardsStackViewDelegate?
	private var cardViews: [CardView] = []
	private var removedCardModels: [CardViewModel] = []
	
	private var topCard: CardView? {
		return cardViews.last
	}
	
	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		layer.zPosition = 1 // place CardsStackView above all other views
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - API
	
	func add(_ cardViewModel: CardViewModel) {
		let cardView = CardView(viewModel: cardViewModel)
		cardView.delegate = self

		cardViews.append(cardView)
		
		addSubview(cardView)
		cardView.constrainToSuperview()
	}
	
	func add(_ cardViewModels: [CardViewModel]) {
		cardViewModels.forEach { add($0) }
	}
	
	func add(_ cardViewModelRepresentables: [CardViewModelRepresentable]) {
		cardViewModelRepresentables.forEach { add($0.cardViewModel) }
	}
	
	func removeTopCard(decision: RelationshipDecision) {
		topCard?.remove(decision: decision)
	}
	
	func undoLastRemoval() {
		guard removedCardModels.isNotEmpty else { return }
		
		add(removedCardModels.removeLast())
	}
	
	func cancelAllUserInteractions() {
		topCard?.cancelAllUserInteractions()
	}
}


// MARK: - CardViewDelegate

extension CardsStackView: CardViewDelegate {
	func cardDidSwiped(_ cardView: CardView, decision: RelationshipDecision) {
		guard cardView === topCard else { return }

		cardViews.removeLast()
		cardView.removeFromSuperview()
		
		removedCardModels.append(cardView.viewModel)
		delegate?.cardDidSwiped(cardId: cardView.viewModel.cardId, decision: decision)
	}
	
	func showMoreInfoButtonDidPressed(for cardId: String) {
		delegate?.showMoreInfoButtonDidPressed(for: cardId)
	}
}
