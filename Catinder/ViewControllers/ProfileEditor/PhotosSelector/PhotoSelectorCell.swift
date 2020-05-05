//
//  PhotoSelectorCell.swift
//  Catinder
//
//  Created by Aleksey on 04.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
	private let placeholderImage = UIImage(named: "PhotoPlaceholder")
	private let photoImageView = CatinderImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		// background
		contentView.backgroundColor = .background
		contentView.layer.setBorder(size: 1, color: .photoSelectorBorder)
		contentView.clipsToBounds = true

		// photo image
		photoImageView.tintColor = .photoSelectorPlaceholderImage
		contentView.addSubview(photoImageView)
		photoImageView.constrainToSuperview()
	}
	
	func set(image: UIImage?) {
		photoImageView.set(image ?? placeholderImage)
		
		if image == nil {
			contentView.layer.borderWidth = 1
			photoImageView.contentMode = .scaleAspectFit
		} else {
			contentView.layer.borderWidth = 0
			photoImageView.contentMode = .scaleAspectFill
		}
	}
	
	func showActivityIndicator() {
		photoImageView.showActivityIndicator()
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		set(image: nil)
	}
}
