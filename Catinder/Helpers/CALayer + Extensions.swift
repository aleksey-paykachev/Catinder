//
//  CALayer + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 17/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import QuartzCore

extension CALayer {
	
	/// Animate changes to current layer transform.
	///
	/// - Parameters:
	///   - final3dTransformState: Defines the final transform state.
	///   - duration: Duration of the animation.
	///   - easing: Easing timing function for animation.
	///   - completion: A block object to be executed when the animation sequence ends.
	///
	func animateTransform(to final3dTransformState: CATransform3D, duration: TimeInterval, easing: CAMediaTimingFunctionName = .linear, completion: @escaping () -> ()) {
		
		// setup animation
		let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
		animation.duration = duration
		animation.fromValue = transform
		animation.toValue = final3dTransformState
		animation.timingFunction = CAMediaTimingFunction(name: easing)
		
		// fire animation
		CATransaction.begin()
		CATransaction.setCompletionBlock {
			completion()
		}
		transform = final3dTransformState // set final state to prevent layer fall back
		add(animation, forKey: "transform")
		CATransaction.commit()
	}
	
	/// Set rounded corners for current layer using provided radius.
	///
	/// - Parameter radius: Radius value applying to corners. If no value were provided,
	///						use half of the layers width, i.e. make squared layer a circle.
	///
	func round(radius: CGFloat? = nil) {
		if let radius = radius {
			cornerRadius = radius
		} else {
			cornerRadius = frame.width / 2
		}

		masksToBounds = true
	}
}
