//
//  UIView + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIView {
	
	/// OptionSet which allows to specify separate edges to constraint.
	///
	struct ConstraintEdges: OptionSet {
		let rawValue: Int
		
		static let leading = ConstraintEdges(rawValue: 1 << 0)
		static let trailing = ConstraintEdges(rawValue: 1 << 1)
		static let top = ConstraintEdges(rawValue: 1 << 2)
		static let bottom = ConstraintEdges(rawValue: 1 << 3)
		
		static let all: ConstraintEdges = [.leading, .trailing, .top, .bottom]
	}
	
	
	/// Constraint current view to its superview given edges.
	///
	/// - Parameter edges: edges of superview to constraint to.
	///
	func constraintToSuperview(edges: ConstraintEdges = .all) {
		guard let superview = superview else { return }
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if edges.contains(.leading) {
			leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
		}
		
		if edges.contains(.trailing) {
			trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
		}
		
		if edges.contains(.top) {
			topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
		}
		
		if edges.contains(.bottom) {
			bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
		}
	}
	
	/// Set fixed height using height constraint.
	///
	/// - Parameter height: height constant.
	///
	func constraintHeight(to height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
	}
}
