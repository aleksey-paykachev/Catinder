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
	private let defaultEmptyImage = UIImage(systemName: "xmark")
	private let photoImageView = UIImageView()
	private let activityIndicatorView = UIActivityIndicatorView(style: .large)
	
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
		photoImageView.contentMode = .scaleAspectFill
		photoImageView.tintColor = .lightGray
		contentView.addSubview(photoImageView)
		photoImageView.constrainToSuperview()
		
		// activity indicator
		activityIndicatorView.hidesWhenStopped = true
		activityIndicatorView.color = .activityIndicator
		photoImageView.addSubview(activityIndicatorView)
		activityIndicatorView.constrainToSuperview(anchors: [.centerX, .centerY])
	}
	
	func set(imageName: String?) {
		guard let imageName = imageName else {
			set(image: nil)
			return
		}
		
		DataManager.shared.getImage(name: imageName) { [weak self] image, _ in
			self?.set(image: image)
		}
	}
	
	func set(image: UIImage?) {
		contentView.layer.borderWidth = image == nil ? 1 : 0 // show/hide border
		photoImageView.image = image ?? defaultEmptyImage
	}
	
	func showActivityIndicator() {
		activityIndicatorView.startAnimating()
	}
	
	func hideActivityIndicator() {
		 activityIndicatorView.stopAnimating()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()

		photoImageView.image = defaultEmptyImage
		hideActivityIndicator()
	}
}
