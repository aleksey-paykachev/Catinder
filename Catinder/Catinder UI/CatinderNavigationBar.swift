//
//  CatinderNavigationBar.swift
//  Catinder
//
//  Created by Aleksey on 23/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderNavigationBar: UIView {
	
	let title: String
	let height: CGFloat = 100
	
	
	// MARK: - Init
	
	init(title: String) {
		self.title = title
		
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		constrainToSuperview(anchors: [.top, .leading, .trailing], respectSafeArea: false)
		constrainHeight(to: height)
	}
	
	private func setupView() {
		backgroundColor = .white
		
		// shadow
		layer.shadowColor = .black
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 6
		layer.shadowOpacity = 0.2
		
		// content area
		let contentArea = UIView()
		addSubview(contentArea)
		contentArea.constrainToSuperview(paddings: .horizontal(12), respectSafeArea: true)
		
		// back button
		let backButton = UIButton(type: .system)
		#warning("Add real back buton image.")
		backButton.backgroundColor = .red
		contentArea.addSubview(backButton)
		backButton.constrainToSuperview(anchors: [.leading, .centerY])
		
		// title
		let titleLabel = UILabel(text: title, font: .systemFont(ofSize: 20, weight: .medium))
		contentArea.addSubview(titleLabel)
		titleLabel.constrainToSuperview(anchors: [.centerX, .centerY])
	}
}

