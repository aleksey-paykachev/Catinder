//
//  CatinderTextField.swift
//  Catinder
//
//  Created by Aleksey on 16.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderTextField: UITextField {
	// MARK: - Init
	
	init(placeholder: String? = nil, useAutoCorrection: Bool = false) {
		super.init(frame: .zero)
		
		self.placeholder = placeholder
		autocorrectionType = useAutoCorrection ? .yes : .no
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	private func setupView() {
		backgroundColor = .textFieldBackground
		layer.setBorder(size: 1.5, color: .textFieldBorder)
		layer.setCorner(radius: 6)
	}
	
	// override textRect and editingRect to set inner bounds insets for placeholder and text
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		super.textRect(forBounds: bounds).insetBy(dx: 8, dy: 0)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		super.editingRect(forBounds: bounds).insetBy(dx: 8, dy: 0)
	}

	
	// MARK: - API
	
	func showWrongInputAnimation() {
		// show short "shake" animation
		transform = transform.translatedBy(x: 8, y: 0)
		
		UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, animations: {

			self.transform = .identity
		})
		
		// and temporary change border color to indicate wrong user input
		let borderColorAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderColor))
		borderColorAnimation.duration = 0.3
		borderColorAnimation.autoreverses = true
		borderColorAnimation.fromValue = layer.borderColor
		borderColorAnimation.toValue = UIColor.error.cgColor
		
		layer.add(borderColorAnimation, forKey: nil)
	}
}
