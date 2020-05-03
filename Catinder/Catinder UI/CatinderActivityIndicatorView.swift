//
//  CatinderActivityIndicatorView.swift
//  Catinder
//
//  Created by Aleksey on 03.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderActivityIndicatorView: UIActivityIndicatorView {
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		style = .large
		hidesWhenStopped = true
		color = .activityIndicator
	}
	
	func show() {
		startAnimating()
	}
	
	func hide() {
		stopAnimating()
	}
}
