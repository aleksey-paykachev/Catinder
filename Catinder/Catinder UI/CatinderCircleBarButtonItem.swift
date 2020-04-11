//
//  CatinderCircleBarButtonItem.swift
//  Catinder
//
//  Created by Aleksey on 09.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderCircleBarButtonItem: UIBarButtonItem {
	
	private let imageButton: CatinderNavigationButton
	private var clickEvent: (() -> ())?
	
	init(image: UIImage? = nil) {
		imageButton = CatinderNavigationButton(radius: 18, image: image)

		super.init()
		customView = imageButton
		imageButton.addTarget(self, action: #selector(buttonDidPressed), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(image: UIImage?) {
		imageButton.set(image: image)
	}
	
	func set(imageName: String) {
		imageButton.set(image: UIImage(named: imageName))
	}
	
	func onClick(_ clickEvent: @escaping () -> ()) {
		self.clickEvent = clickEvent
	}
	
	@objc private func buttonDidPressed() {
		clickEvent?()
	}
}
