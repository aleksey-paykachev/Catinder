//
//  TopMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class TopMenuView: UIView {
	private var catinderLogoImage: UIImage!
	private var profileButton: UIButton!
	private var messagesButton: UIButton!
	
	init() {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		backgroundColor = .green
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: 100).isActive = true
	}
}
