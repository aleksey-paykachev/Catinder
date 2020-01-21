//
//  BottomMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol BotomMenuActionsDelegate: class {
	func undoButtonDidPressed()
	func dislikeButtonDidPressed()
	func likeButtonDidPressed()
	func superLikeButtonDidPressed()
}

class BottomMenuView: UIView {
	// MARK: - Properties

	weak var delegate: BotomMenuActionsDelegate?
	
	// Buttons
	private lazy var undoButton = CatinderImageButton("Undo") { [weak self] in
		self?.delegate?.undoButtonDidPressed()
	}

	private lazy var dislikeButton = CatinderImageButton("Dislike") { [weak self] in
		self?.delegate?.dislikeButtonDidPressed()
	}

	private let boostProfileButton = CatinderImageButton("Boost") {
		print("Boost")
	}

	private lazy var likeButton = CatinderImageButton("Like") { [weak self] in self?.delegate?.likeButtonDidPressed()
	}

	private lazy var superLikeButton = CatinderImageButton("SuperLike") { [weak self] in
		self?.delegate?.superLikeButtonDidPressed()
	}
	
	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		constrainHeight(to: 80)
		
		let stackView = UIStackView(arrangedSubviews: [undoButton, dislikeButton, boostProfileButton, likeButton, superLikeButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		
		addSubview(stackView)
		stackView.constrainToSuperview()
	}
}
