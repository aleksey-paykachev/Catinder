//
//  ProfilePhotoSelectorCell.swift
//  Catinder
//
//  Created by Aleksey on 04.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfilePhotoSelectorCell: UICollectionViewCell {
	private var photoImageView = UIImageView(image: UIImage(systemName: "xmark"))
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		contentView.backgroundColor = .background
//		contentView.layer.cornerRadius = 10
//		contentView.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1).cgColor
//		contentView.layer.borderWidth = 1
		contentView.clipsToBounds = true
		
		let borderLayer = CAShapeLayer()
		borderLayer.strokeColor = UIColor.lightGray.cgColor
		borderLayer.fillColor = nil
		borderLayer.lineWidth = 4
		borderLayer.lineDashPattern = [5, 5]
		borderLayer.frame = contentView.bounds
		borderLayer.path = CGPath(rect: contentView.bounds, transform: nil)
		contentView.layer.addSublayer(borderLayer)

		photoImageView.contentMode = .scaleAspectFit // .scaleAspectFill
		photoImageView.tintColor = .lightGray
		contentView.addSubview(photoImageView)
		photoImageView.constrainToSuperview()
	}
	
	func set(image: UIImage) {
		photoImageView.image = image
	}
}
