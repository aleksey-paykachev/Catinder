//
//  GradientView.swift
//  Catinder
//
//  Created by Aleksey on 21/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class GradientView: UIView {
	
	private let gradientLayer = CAGradientLayer()
	
	
	// MARK: - Init
	
	init(_ colors: [UIColor], at locations: [Double]) {
		super.init(frame: .zero)
		
		setupGradient(with: colors, at: locations)
		contentMode = .redraw
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup and redraw
	
	private func setupGradient(with colors: [UIColor], at locations: [Double]) {
		gradientLayer.colors = colors.map { $0.cgColor }
		gradientLayer.locations = locations.map(NSNumber.init(value:))
		layer.addSublayer(gradientLayer)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		gradientLayer.frame = rect
	}
}
