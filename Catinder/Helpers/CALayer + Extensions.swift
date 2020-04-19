//
//  CALayer + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 17/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension CALayer {
	
	/// Animate changes to current layer transform.
	///
	/// - Parameters:
	///   - final3dTransformState: Defines the final transform state.
	///   - duration: Duration of the animation.
	///   - easing: Easing timing function for animation.
	///   - completion: A block object to be executed when the animation sequence ends.
	///
	func animateTransform(to final3dTransformState: CATransform3D,
						  duration: TimeInterval,
						  reverse: Bool = false,
						  easing: CAMediaTimingFunctionName = .linear,
						  completion: @escaping () -> ()) {
		
		// setup animation
		let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
		animation.duration = duration
		animation.fromValue = transform
		animation.toValue = final3dTransformState
		animation.timingFunction = CAMediaTimingFunction(name: easing)
		animation.autoreverses = reverse
		
		// fire animation
		CATransaction.begin()
		CATransaction.setCompletionBlock {
			completion()
		}
		transform = final3dTransformState // set final state to prevent layer fall back
		add(animation, forKey: "transform")
		CATransaction.commit()
	}
	
	/// Set rounded corners for current layer. Use half of the layers side with the
	/// minimum size, i.e. make squared layer a circle and round rectangular.
	///
	func roundCorners() {
		cornerRadius = min(frame.width / 2, frame.height / 2)
		masksToBounds = true
	}
	
	/// Set rounded corners for current layer using provided radius.
	///
	/// - Parameter radius: Radius value applying to corners.
	///
	func setCorner(radius: CGFloat) {
		cornerRadius = radius
		masksToBounds = true
	}
	
	/// Set border for current layer.
	///
	/// - Parameters:
	///   - size: Size of the border.
	///   - color: Color of the border.
	///
	func setBorder(size: CGFloat, color: UIColor = .black) {
		borderWidth = size
		borderColor = color.cgColor
	}
	
	/// Set shadow for current layer.
	///
	/// - Parameters:
	///   - color: The color of the layer’s shadow.
	///   - size: The blur radius used to render the layer’s shadow.
	///   - offsetX: The X offset of the layer’s shadow.
	///   - offsetY: The Y offset of the layer’s shadow.
	///   - alpha: The opacity of the layer’s shadow.
	///
	func setShadow(color: UIColor = .black, size: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat = 0, alpha: CGFloat = 1) {
		
		shadowColor = color.cgColor
		shadowRadius = size
		shadowOffset = CGSize(width: offsetX, height: offsetY)
		shadowOpacity = Float(alpha)
	}
}
