//
//  UIView + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIView {
	
	/// OptionSet which allows to specify separate anchors to constrain.
	///
	struct Anchors: OptionSet {
		let rawValue: UInt8
		
		static let leading = Anchors(rawValue: 1 << 0)
		static let trailing = Anchors(rawValue: 1 << 1)
		static let top = Anchors(rawValue: 1 << 2)
		static let bottom = Anchors(rawValue: 1 << 3)
		
		static let centerX = Anchors(rawValue: 1 << 4)
		static let centerY = Anchors(rawValue: 1 << 5)
		
		static let allEdges: Anchors = [.leading, .trailing, .top, .bottom]
	}
	
	/// Padding structure allows specify paddings to constrained edges.
	///
	struct Padding {
		let leading: CGFloat
		let trailing: CGFloat
		let top: CGFloat
		let bottom: CGFloat
		
		static func leading(_ padding: CGFloat) -> Padding {
			Padding(leading: padding, trailing: 0, top: 0, bottom: 0)
		}
		
		static func trailing(_ padding: CGFloat) -> Padding {
			Padding(leading: 0, trailing: padding, top: 0, bottom: 0)
		}

		static func top(_ padding: CGFloat) -> Padding {
			Padding(leading: 0, trailing: 0, top: padding, bottom: 0)
		}

		static func bottom(_ padding: CGFloat) -> Padding {
			Padding(leading: 0, trailing: 0, top: 0, bottom: padding)
		}
		
		static func vertical(_ padding: CGFloat) -> Padding {
			Padding(leading: 0, trailing: 0, top: padding, bottom: padding)
		}
		
		static func horizontal(_ padding: CGFloat) -> Padding {
			Padding(leading: padding, trailing: padding, top: 0, bottom: 0)
		}
		
		static func all(_ padding: CGFloat) -> Padding {
			Padding(leading: padding, trailing: padding, top: padding, bottom: padding)
		}
	}
	
	/// Constrain current view to another view.
	///
	/// - Parameters:
	///   - secondView: View wich current view are constrains to. Must have common ancestor.
	///   - anchors: Anchors of second view to constrain to.
	///   - paddings: Padding values for all constrained edges.
	///   - respectSafeArea: Take safe area layout guide into account.
	///
	func constrainTo(_ secondView: UIView, anchors: Anchors = .allEdges, paddings: Padding = .all(0), respectSafeArea: Bool = true) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if anchors.contains(.leading) {
			let secondViewLeadingAnchor = respectSafeArea ? secondView.safeAreaLayoutGuide.leadingAnchor : secondView.leadingAnchor
			leadingAnchor.constraint(equalTo: secondViewLeadingAnchor, constant: paddings.leading).isActive = true
		}
		
		if anchors.contains(.trailing) {
			let secondViewTrailingAnchor = respectSafeArea ? secondView.safeAreaLayoutGuide.trailingAnchor : secondView.trailingAnchor
			trailingAnchor.constraint(equalTo: secondViewTrailingAnchor, constant: -paddings.trailing).isActive = true
		}
		
		if anchors.contains(.top) {
			let secondViewTopAnchor = respectSafeArea ? secondView.safeAreaLayoutGuide.topAnchor : secondView.topAnchor
			topAnchor.constraint(equalTo: secondViewTopAnchor, constant: paddings.top).isActive = true
		}
		
		if anchors.contains(.bottom) {
			let secondViewBottomAnchor = respectSafeArea ? secondView.safeAreaLayoutGuide.bottomAnchor : secondView.bottomAnchor
			bottomAnchor.constraint(equalTo: secondViewBottomAnchor, constant: -paddings.bottom).isActive = true
		}
		
		if anchors.contains(.centerX) {
			centerXAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
		}
		
		if anchors.contains(.centerY) {
			centerYAnchor.constraint(equalTo: secondView.centerYAnchor).isActive = true
		}
	}
	
	/// Constrain current view to its superview.
	///
	/// - Parameters:
	///   - anchors: Anchors of superview to constrain to.
	///   - paddings: Padding values for all constrained edges.
	///   - respectSafeArea: Take safe area layout guide into account.
	///
	func constrainToSuperview(anchors: Anchors = .allEdges, paddings: Padding = .all(0), respectSafeArea: Bool = true) {
		guard let superview = superview else { return }
		
		constrainTo(superview, anchors: anchors, paddings: paddings, respectSafeArea: respectSafeArea)
	}
	
	/// Constrain current view to fixed width.
	///
	/// - Parameter width: Width constant.
	///
	func constrainWidth(to width: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(equalToConstant: width).isActive = true
	}
	
	/// Constrain current view to fixed height.
	///
	/// - Parameter height: Height constant.
	///
	func constrainHeight(to height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
	}
	
	/// Constrain current view to fixed width and height.
	///
	/// - Parameters:
	///   - width: Width constant.
	///   - height: Height constant.
	///
	func constrainSize(width: CGFloat, height: CGFloat) {
		constrainWidth(to: width)
		constrainHeight(to: height)
	}
	
	/// Constrain current view to fixed width and height.
	///
	/// - Parameters:
	///   - size: Size structure with width and height values.
	///
	func constrainSize(to size: CGSize) {
		constrainWidth(to: size.width)
		constrainHeight(to: size.height)
	}
}


// MARK: - UIView.Padding + Extensions

extension UIView.Padding {

	/// Sums up all values from two padding structures and returns new, result instance.
	/// - Parameters:
	///   - lhs: First padding structure.
	///   - rhs: Second padding structure.
	///
	static func +(lhs: UIView.Padding, rhs: UIView.Padding) -> UIView.Padding {
		UIView.Padding(leading: lhs.leading + rhs.leading,
					   trailing: lhs.trailing + rhs.trailing,
					   top: lhs.top + rhs.top,
					   bottom: lhs.bottom + rhs.bottom)
	}
}
