//
//  CGSize + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 18/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import CoreGraphics

extension CGSize {
	/// Creates and returns a CGSize instance with equal width and height.
	///
	/// - Parameter side: Side value of the square.
	/// - Returns: CGSize instance.
	///
	static func square(_ side: CGFloat) -> CGSize {
		return CGSize(width: side, height: side)
	}
}
