//
//  ErrorMessageView.swift
//  Catinder
//
//  Created by Aleksey on 06.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ErrorMessageView: UIView {
	// MARK: - Init
	
	private let message: String
	
	init(message: String) {
		self.message = message
		super.init(frame: .zero)

		setupView()
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		isOpaque = false
		
		layer.setCorner(radius: 12)
	}
	
	private func setupSubviews() {
		// blur background
		let blurEffect = UIBlurEffect(style: .systemMaterialDark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		addSubview(blurEffectView)
		blurEffectView.constrainToSuperview()
		
		// message label
		let messageLabel = UILabel(text: message, color: .white, alignment: .center, allowMultipleLines: true)
		
		addSubview(messageLabel)
		messageLabel.constrainToSuperview(paddings: .all(18))
	}
}

