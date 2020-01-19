//
//  CatinderSecondaryTextButton.swift
//  Catinder
//
//  Created by Aleksey on 20/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderSecondaryTextButton: CatinderPrimaryTextButton {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		guard let gradientLayer = layer.sublayers?.first else { return }
		
		// constants
		let radius = rect.width / 2
		let borderWidth: CGFloat = 2
		
		// cut hole inside gradient layer to create border with gradient
		let maskLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
		path.addPath(UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), cornerRadius: radius).cgPath)
		maskLayer.path = path
		maskLayer.fillRule = .evenOdd
		gradientLayer.mask = maskLayer
	}
}
