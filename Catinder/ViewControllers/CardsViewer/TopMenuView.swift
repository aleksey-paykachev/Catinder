//
//  TopMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class TopMenuView: UIView {
	private let catinderLogoImageView = UIImageView()
	private let profileButton = UIButton(type: .custom)
	private let messagesButton = UIButton(type: .custom)
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init() {
		super.init(frame: .zero)
		
		setupSubviews()
		setupView()
	}
	
	private func setupSubviews() {
		catinderLogoImageView.image = UIImage(named: "temporaryLogo")
		catinderLogoImageView.contentMode = .scaleAspectFit
		
		profileButton.setImage(UIImage(named: "Profile"), for: .normal)
		profileButton.contentMode = .scaleAspectFit
		
		messagesButton.setImage(UIImage(named: "Messages"), for: .normal)
		messagesButton.contentMode = .scaleAspectFit
	}
	
	private func setupView() {
		backgroundColor = .green
		constraintHeight(to: 100)
		
		let stackView = UIStackView(arrangedSubviews: [profileButton, catinderLogoImageView, messagesButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually

		// layout
		addSubview(stackView)
		stackView.constraintToSuperview()
	}
}
