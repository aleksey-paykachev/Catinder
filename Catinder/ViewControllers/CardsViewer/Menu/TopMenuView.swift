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
	private lazy var profileButton = MenuButton(imageName: "Profile") { [weak self] in
		self?.delegate?.profileButtonDidPressed()
	}
	
	private lazy var messagesButton = MenuButton(imageName: "Messages") { [weak self] in
		self?.delegate?.messagesButtonDidPressed()
	}
	
	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		
		setupSubviews()
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupSubviews() {
		logoImageView.image = UIImage(named: "temporaryLogo")
		logoImageView.contentMode = .scaleAspectFit
	}
	
	private func setupView() {
		constrainHeight(to: 30)
		
		let stackView = UIStackView(arrangedSubviews: [profileButton, logoImageView, messagesButton])
		stackView.axis = .horizontal
		stackView.distribution = .equalCentering

		addSubview(stackView)
		stackView.constrainToSuperview()
	}
}
