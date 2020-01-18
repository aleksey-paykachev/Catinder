//
//  UILabel + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 08/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UILabel {
	
	/// A view that displays one or more lines of read-only text.
	///
	/// - Parameters:
	///   - text: Text that will be displayed by the label.
	///   - color: The color of the text.
	///   - alignment: Alignment of the text.
	///   - allowMultipleLines: Enables support of multiple lines for current label.
	///   - font: The font used to display the text.
	///
	convenience init(text: String = "", color: UIColor = .black, alignment: NSTextAlignment = .left, allowMultipleLines: Bool = false, font: UIFont? = nil) {
		self.init()

		self.text = text
		textColor = color
		textAlignment = alignment
		numberOfLines = allowMultipleLines ? 0 : 1
		
		if let font = font {
			self.font = font
		}
	}

	/// Capitalize text inside current label
	///
	func capitalizeText() {
		text = text?.capitalized
	}
}
