//
//  BottomMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class BottomMenuView: UIView {
	private var undoButton: UIButton!
	private var dislikeButton: UIButton!
	private var boostProfileButton: UIButton!
	private var likeButton: UIButton!
	private var superLikeButton: UIButton!
	
	init() {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		backgroundColor = .purple
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: 80).isActive = true
	}
}
