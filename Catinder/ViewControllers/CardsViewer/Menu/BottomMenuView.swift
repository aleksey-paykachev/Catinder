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
	func boostButtonDidPressed()
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

	private lazy var boostProfileButton = CatinderImageButton("Boost") { [weak self] in
		self?.delegate?.boostButtonDidPressed()
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
		let stackView = HStackView([undoButton, dislikeButton, boostProfileButton, likeButton, superLikeButton], distribution: .fillEqually)
		
		constrainHeight(to: 80)
		addSubview(stackView)
		stackView.constrainToSuperview()
	}
	
	
	// MARK: - Boost button actions
	
	func setBoostButtonInPendingState() {
		boostProfileButton.isEnabled = false
	}
	
	func setBoostButtonInNormalState() {
		boostProfileButton.isEnabled = true
	}
	
	func activateBoostOption(for activationTime: DispatchTimeInterval) {
		#warning("TODO: Add activation animation.")
		boostProfileButton.isEnabled = false

		DispatchQueue.main.asyncAfter(deadline: .now() + activationTime) { [weak self] in
			self?.setBoostButtonInNormalState()
		}
	}
}
