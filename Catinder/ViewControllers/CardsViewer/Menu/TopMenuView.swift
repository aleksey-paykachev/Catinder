//
//  TopMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol TopMenuActionsDelegate: class {
	func profileButtonDidPressed()
	func messagesButtonDidPressed()
}

class TopMenuView: UIView {
	// MARK: - Properties

	weak var delegate: TopMenuActionsDelegate?

	private let logoImageView = UIImageView()

	// buttons
	private lazy var profileButton = CatinderImageButton("Profile") { [weak self] in
		self?.delegate?.profileButtonDidPressed()
	}
	
	private lazy var messagesButton = CatinderImageButton("Messages") { [weak self] in
		self?.delegate?.messagesButtonDidPressed()
	}
	
	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		
		setupLogoImageView()
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupLogoImageView() {
		let logoImage = UIImage(named: "CatinderLogo")
		logoImageView.image = logoImage
		logoImageView.contentMode = .scaleAspectFit
		
		let logoImageAspectRatio = logoImage!.size.width / logoImage!.size.height
		logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: logoImageAspectRatio).isActive = true
	}
	
	private func setupView() {
		let stackView = HStackView([profileButton, logoImageView, messagesButton], distribution: .equalCentering)

		constrainHeight(to: 30)
		addSubview(stackView)
		stackView.constrainToSuperview()
	}
}
