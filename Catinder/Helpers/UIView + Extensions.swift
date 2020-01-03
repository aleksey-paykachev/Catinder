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
		let rawValue: UInt8
		
		static let leading = ConstraintEdges(rawValue: 1 << 0)
		static let trailing = ConstraintEdges(rawValue: 1 << 1)
		static let top = ConstraintEdges(rawValue: 1 << 2)
		static let bottom = ConstraintEdges(rawValue: 1 << 3)
		
		static let all: ConstraintEdges = [.leading, .trailing, .top, .bottom]
	}
	
	/// Constraint current view to its superview.
	///
	/// - Parameters:
	///   - edges: Edges of superview to constraint to.
	///   - insets: Inset values for all constrained edges.
	///
	func constraintToSuperview(edges: ConstraintEdges = .all, insets: UIEdgeInsets = .zero) {
		guard let superview = superview else { return }
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if edges.contains(.leading) {
			leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left).isActive = true
		}
		
		if edges.contains(.trailing) {
			trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right).isActive = true
		}
		
		if edges.contains(.top) {
			topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top).isActive = true
		}
		
		if edges.contains(.bottom) {
			bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom).isActive = true
		}
	}
	
	/// Set fixed height using height constraint.
	///
	/// - Parameter height: Height constant.
	///
	func constraintHeight(to height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
	}
}
