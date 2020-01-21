//
//  CatinderPrimaryTextButton.swift
//  Catinder
//
//  Created by Aleksey on 19/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderPrimaryTextButton: UIButton {
	
	let gradientLayer = CAGradientLayer()
	
	convenience init(text: String) {
		self.init(type: .system)
		
		setupButton(with: text)
		setupGradient()
		
		contentMode = .redraw
	}
	
	private func setupButton(with text: String) {
		// text
		setTitle(text, for: .normal)
		setTitleColor(.white, for: .normal)
		titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)

		// shadow
		setTitleShadowColor(.darkGray, for: .normal)
		titleLabel?.shadowOffset = CGSize(width: 1, height: 1)
	}
	
	private func setupGradient() {
		gradientLayer.type = .radial
		gradientLayer.colors = [UIColor.orange.cgColor, UIColor.red.cgColor, #colorLiteral(red: 0.7800404505, green: 0, blue: 0.007302548011, alpha: 1).cgColor]
		gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.1)
		gradientLayer.endPoint = CGPoint(x: 1.6, y: 1.3)
		
		layer.insertSublayer(gradientLayer, at: 0)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		layer.roundCorners()
		gradientLayer.frame = rect
	}
}
