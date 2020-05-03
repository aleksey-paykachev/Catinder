//
//  CatinderImageView.swift
//  Catinder
//
//  Created by Aleksey on 03.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderImageView: UIImageView {
	private let activityIndicatorView = CatinderActivityIndicatorView()
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		contentMode = .scaleAspectFill
		
		addSubview(activityIndicatorView)
		activityIndicatorView.constrainToSuperview(anchors: [.centerX, .centerY])
	}
	
	func showActivityIndicator() {
		activityIndicatorView.show()
	}
	
	func set(_ image: UIImage?) {
		self.image = image
		activityIndicatorView.hide()
	}
}
