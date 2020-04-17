//
//  PhotoSelectorButton.swift
//  Catinder
//
//  Created by Aleksey on 15/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotoSelectorButton: UIButton {
	let photoId: Int
	let tapCallback: (Int) -> ()
	
	init(photoId: Int, tapCallback: @escaping (Int) -> ()) {
		self.photoId = photoId
		self.tapCallback = tapCallback

		super.init(frame: .zero)
		setupView()
		setupActions()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		backgroundColor = .background
		layer.cornerRadius = 10
		layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1).cgColor
		layer.borderWidth = 1
		clipsToBounds = true
		setTitleColor(#colorLiteral(red: 0.7843137255, green: 0.7858179953, blue: 0.7858179953, alpha: 1), for: .normal)
		titleLabel?.font = .systemFont(ofSize: 18)
		setTitle("Выберите фото", for: .normal)
		imageView?.contentMode = .scaleAspectFill
	}
	
	private func setupActions() {
		addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
	}
	
	@objc private func buttonDidTapped() {
		tapCallback(photoId)
	}
}
