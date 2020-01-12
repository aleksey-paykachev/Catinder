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
	///   - respectSafeArea: Take safe area layout guide into account.
	///
	func constraintToSuperview(edges: ConstraintEdges = .all, insets: UIEdgeInsets = .zero, respectSafeArea: Bool = true) {
		guard let superview = superview else { return }
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if edges.contains(.leading) {
			let superviewLeadingAnchor = respectSafeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor
			leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: insets.left).isActive = true
		}
		
		if edges.contains(.trailing) {
			let superviewTrailingAnchor = respectSafeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor
			trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -insets.right).isActive = true
		}
		
		if edges.contains(.top) {
			let superviewTopAnchor = respectSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
			topAnchor.constraint(equalTo: superviewTopAnchor, constant: insets.top).isActive = true
		}
		
		if edges.contains(.bottom) {
			let superviewBottomAnchor = respectSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor
			bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -insets.bottom).isActive = true
		}
	}
	
	/// Constraint current view to its superview.
	///
	/// - Parameters:
	///   - edges: Edges of superview to constraint to.
	///   - allEdgesInset: Inset value for all constrained edges.
	///   - respectSafeArea: Take safe area layout guide into account.
	///
	func constraintToSuperview(edges: ConstraintEdges = .all, allEdgesInset inset: CGFloat, respectSafeArea: Bool = true) {
		constraintToSuperview(edges: edges, insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset), respectSafeArea: respectSafeArea)
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
