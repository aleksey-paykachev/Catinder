//
//  CatinderMarkSignView.swift
//  Catinder
//
//  Created by Aleksey on 21.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderMarkSignView: UIView {

	private let shapeLayer = CAShapeLayer()
	private let lineWidth: CGFloat = 1.5
	private let showBorder = false
	private let animationDuration: CFTimeInterval = 0.3
	
	private let shapeColor: UIColor = .systemGreen
	private let borderColor: UIColor = .darkGray
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	/// Show mark sign.
	/// - Parameter animated: If true, show mark sign with animation. Default value is true.
	///
	func show(animated: Bool = true) {
		shapeLayer.isHidden = false

		if animated {
			playAnimation()
		}
	}
	
	/// Hide mark sign.
	func hide() {
		shapeLayer.isHidden = true
	}
	
	private func setup() {
		backgroundColor = .clear
		shapeLayer.lineWidth = lineWidth
		shapeLayer.lineCap = .round
		shapeLayer.lineJoin = .round

		shapeLayer.fillColor = nil
		shapeLayer.strokeColor = shapeColor.cgColor // inner shape
		if showBorder {
			shapeLayer.setShadow(color: borderColor, size: 1) // outer border
		}
		
		layer.addSublayer(shapeLayer)
		hide()
	}
	
	private func playAnimation() {
		let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
		
		animation.fromValue = 0.0
		animation.toValue = 1.0
		animation.duration = animationDuration
		
		shapeLayer.removeAnimation(forKey: "drawLineAnimation")
		shapeLayer.add(animation, forKey: "drawLineAnimation")
	}
	
	private func getMarkSignPath(in rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		path.move(to: CGPoint(x: lineWidth, y: rect.midY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - lineWidth))
		path.addLine(to: CGPoint(x: rect.maxX - lineWidth, y: lineWidth))

		return path
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		shapeLayer.path = getMarkSignPath(in: bounds).cgPath
	}
}
