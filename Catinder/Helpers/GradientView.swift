//
//  GradientView.swift
//  Catinder
//
//  Created by Aleksey on 21/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

/// UIView with gradient layer.
class GradientView: UIView {
	
	private let gradientLayer = CAGradientLayer()
	
	
	// MARK: - Init
	
	/// Creates and returns new GradientView instance with provided parameters.
	/// - Parameters:
	///   - colors: An array of color objects defining the color of each gradient stop.
	///   - locations: An array of numbers defining the location of each gradient stop.
	///
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
