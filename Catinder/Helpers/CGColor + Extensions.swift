//
//  CGColor + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 16/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension CGColor {
	
	/// A color object whose grayscale and alpha values are both 0.0.
	///
	static var clear: CGColor {
		UIColor.clear.cgColor
	}
	
	/// A color object whose grayscale value is 0.0 and whose alpha value is 1.0.
	///
	static var black: CGColor {
		UIColor.black.cgColor
	}
	
	/// Creates and returns a color object that has the same color component values
	/// as the receiver, but has the specified alpha component.
	///
	/// - Parameter alpha: The opacity value of the new color object.
	/// - Returns: The new CGColor object.
	///
	func withAlphaComponent(_ alpha: CGFloat) -> CGColor {
		UIColor(cgColor: self).withAlphaComponent(alpha).cgColor
	}
}
