//
//  UIStackView + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 03/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIStackView {
	
	/// Removes all arranged subviews from the stack.
	///
	func removeAllArrangedSubviews() {
		for subview in arrangedSubviews {
			removeArrangedSubview(subview)
			subview.removeFromSuperview()
		}
	}
}
