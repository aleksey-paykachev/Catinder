//
//  CatinderTextButton.swift
//  Catinder
//
//  Created by Aleksey on 19/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderTextButton: UIButton {
	
	convenience init(text: String) {
		self.init(type: .system)
		
		// setup view
		setTitle(text, for: .normal)
		setTitleColor(.white, for: .normal)
		setTitleShadowColor(.darkGray, for: .normal)
		titleLabel?.shadowOffset = CGSize(width: 1, height: 1)
		titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		// round corners
		layer.round()
		
		// add gradient
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = rect
		gradientLayer.type = .radial
		gradientLayer.colors = [UIColor.orange.cgColor, UIColor.red.cgColor, #colorLiteral(red: 0.7800404505, green: 0, blue: 0.007302548011, alpha: 1).cgColor]
		gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.1)
		gradientLayer.endPoint = CGPoint(x: 1.6, y: 1.3)
		layer.insertSublayer(gradientLayer, at: 0)
	}
}
