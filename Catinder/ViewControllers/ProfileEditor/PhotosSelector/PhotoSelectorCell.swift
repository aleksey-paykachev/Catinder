//
//  PhotoSelectorCell.swift
//  Catinder
//
//  Created by Aleksey on 04.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
	#warning("Add placeholder image")
	private let placeholderImage = UIImage(systemName: "xmark")
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
		contentView.layer.setBorder(size: 1, color: #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1))
		contentView.clipsToBounds = true

		// photo image
		photoImageView.tintColor = .lightGray
		contentView.addSubview(photoImageView)
		photoImageView.constrainToSuperview()
	}
	
	func set(image: UIImage?) {
		contentView.layer.borderWidth = image == nil ? 1 : 0 // show/hide border
		photoImageView.set(image ?? placeholderImage)
	}
	
	func showActivityIndicator() {
		photoImageView.showActivityIndicator()
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		set(image: nil)
	}
}
