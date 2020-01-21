//
//  Angle.swift
//  Catinder
//
//  Created by Aleksey on 02/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import CoreGraphics

struct Angle {
	let degrees: CGFloat
	
	var radians: CGFloat {
		return degrees * .pi / 180
	}
	
	init(_ degrees: CGFloat) {
		self.degrees = degrees
	}
}
