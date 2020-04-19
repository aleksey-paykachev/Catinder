//
//  Angle.swift
//  Catinder
//
//  Created by Aleksey on 02/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import CoreGraphics

/// Structure representing plane geometry's angle.
struct Angle {

	/// Current value of the angle in degrees.
	let degrees: CGFloat
	
	/// Current value of the angle in radians.
	var radians: CGFloat {
		degrees * .pi / 180
	}
	
	/// Creates and returns new angle structure.
	/// - Parameter degrees: Initial value of the angle in the degrees.
	///
	init(_ degrees: CGFloat) {
		self.degrees = degrees
	}
}
