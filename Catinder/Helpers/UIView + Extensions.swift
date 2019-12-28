//
//  UIView + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIView {
	func constraintToSuperview() {
		guard let superview = superview else { return }
		
		translatesAutoresizingMaskIntoConstraints = false
		leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
		topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
		trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
		bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
	}
	
	func constraintHeight(to height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
	}
}
