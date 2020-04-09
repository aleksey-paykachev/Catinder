//
//  CatinderCircleButton.swift
//  Catinder
//
//  Created by Aleksey on 09.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderCircleButton: UIButton {

	convenience init(radius: CGFloat, image: UIImage? = nil) {
		self.init(type: .system)
		
		// setup
		imageView?.contentMode = .scaleAspectFill
		set(image: image)

		layer.setBorder(size: 2, color: .lightGray)
		layer.roundCorners(radius: radius)
		
		constrainSize(width: radius * 2, height: radius * 2)
	}
	
	func set(image: UIImage?) {
		let image = image?.withRenderingMode(.alwaysOriginal)
		setImage(image, for: .normal)
	}
}
