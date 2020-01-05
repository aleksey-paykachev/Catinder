//
//  BottomMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol BotomMenuActionsDelegate: class {
	func likeButtonDidPressed()
	func dislikeButtonDidPressed()
}

class BottomMenuView: UIView {
	// MARK: - Properties

	weak var delegate: BotomMenuActionsDelegate?
	
	// Buttons
	private let undoButton = MenuButton(imageName: "Undo") {
		print("Undo")
	}

	private lazy var dislikeButton = MenuButton(imageName: "Dislike") { [weak self] in
		self?.delegate?.dislikeButtonDidPressed()
	}

	private let boostProfileButton = MenuButton(imageName: "Boost") {
		print("Boost")
	}

	private lazy var likeButton = MenuButton(imageName: "Like") { [weak self] in self?.delegate?.likeButtonDidPressed()
	}

	private let superLikeButton = MenuButton(imageName: "SuperLike") {
		print("Super like")
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
		constraintHeight(to: 80)
		
		let stackView = UIStackView(arrangedSubviews: [undoButton, dislikeButton, boostProfileButton, likeButton, superLikeButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		
		addSubview(stackView)
		stackView.constraintToSuperview()
	}
}
