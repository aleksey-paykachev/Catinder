//
//  HStackView.swift
//  Catinder
//
//  Created by Aleksey on 20/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class HStackView: UIStackView {
	
	/// Returns a new horizontal stack view object that manages the provided views.
	///
	/// - Parameters:
	///   - arrangedSubviews: The views to be arranged by the stack view.
	///   - spacing: The distance between the edges of the stack view’s arranged views.
	///   - distribution: The distribution of the arranged views along the axis.
	///
	convenience init(_ arrangedSubviews: [UIView], spacing: CGFloat = 0, distribution: Distribution = .fill) {
		self.init(arrangedSubviews: arrangedSubviews)
		
		axis = .horizontal
		self.spacing = spacing
		self.distribution = distribution
	}
}
