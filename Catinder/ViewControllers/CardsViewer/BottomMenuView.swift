//
//  BottomMenuView.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

class BottomMenuView: UIView {
	private var undoButton = UIButton(type: .custom)
	private var dislikeButton = UIButton(type: .custom)
	private var boostProfileButton = UIButton(type: .custom)
	private var likeButton = UIButton(type: .custom)
	private var superLikeButton = UIButton(type: .custom)
	
	init() {
		super.init(frame: .zero)
		
		setupButtons()
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupButtons() {
		undoButton.setImage(UIImage(named: "Undo"), for: .normal)
		undoButton.imageView?.contentMode = .scaleAspectFit

		dislikeButton.setImage(UIImage(named: "Dislike"), for: .normal)
		dislikeButton.imageView?.contentMode = .scaleAspectFit
		
		boostProfileButton.setImage(UIImage(named: "Boost"), for: .normal)
		boostProfileButton.imageView?.contentMode = .scaleAspectFit
		
		likeButton.setImage(UIImage(named: "Like"), for: .normal)
		likeButton.imageView?.contentMode = .scaleAspectFit
		
		superLikeButton.setImage(UIImage(named: "SuperLike"), for: .normal)
		superLikeButton.imageView?.contentMode = .scaleAspectFit
	}
	
	private func setupView() {
		constraintHeight(to: 80)
		
		let stackView = UIStackView(arrangedSubviews: [undoButton, dislikeButton, boostProfileButton, likeButton, superLikeButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		
		addSubview(stackView)
		stackView.constraintToSuperview()
	}
}
