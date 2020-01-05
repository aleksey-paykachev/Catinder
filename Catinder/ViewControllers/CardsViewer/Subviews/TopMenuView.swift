//
//  TopMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class TopMenuView: UIView {
	private let logoImageView = UIImageView()
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
		logoImageView.image = UIImage(named: "temporaryLogo")
		logoImageView.contentMode = .scaleAspectFit
		
		profileButton.setImage(UIImage(named: "Profile"), for: .normal)
		profileButton.imageView?.contentMode = .scaleAspectFit
		
		messagesButton.setImage(UIImage(named: "Messages"), for: .normal)
		messagesButton.imageView?.contentMode = .scaleAspectFit
	}
	
	private func setupView() {
		constraintHeight(to: 30)
		
		let stackView = UIStackView(arrangedSubviews: [profileButton, logoImageView, messagesButton])
		stackView.axis = .horizontal
		stackView.distribution = .equalCentering

		addSubview(stackView)
		stackView.constraintToSuperview()
	}
}
