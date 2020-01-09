//
//  MenuButton.swift
//  Catinder
//
//  Created by Aleksey on 06/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
	private let imageName: String
	private let touchHandler: () -> ()
	
	init(imageName: String, touchHandler: @escaping () -> ()) {
		self.imageName = imageName
		self.touchHandler = touchHandler
		
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		setImage(UIImage(named: imageName), for: .normal)
		imageView?.contentMode = .scaleAspectFit
		addTarget(self, action: #selector(buttonDidTouched), for: .touchUpInside)
	}
	
	@objc private func buttonDidTouched() {
		touchHandler()
	}
}
