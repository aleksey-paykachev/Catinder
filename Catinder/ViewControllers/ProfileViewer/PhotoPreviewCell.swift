//
//  PhotoPreviewCell.swift
//  Catinder
//
//  Created by Aleksey on 11.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotoPreviewCell: UICollectionViewCell {

	private let photoImageView = UIImageView()
	
	private let alphaSelected: CGFloat = 1
	private let alphaNotSelected: CGFloat = 0.6
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		contentView.addSubview(photoImageView)
		photoImageView.constrainToSuperview()

		photoImageView.layer.setBorder(size: 2, color: #colorLiteral(red: 0.9372549057, green: 0.5500408101, blue: 0.3201948127, alpha: 0.9211526113))
		photoImageView.layer.setCorner(radius: 6)
		photoImageView.alpha = alphaNotSelected
		photoImageView.contentMode = .scaleAspectFill
		photoImageView.clipsToBounds = true
	}
	
	override var isSelected: Bool {
		didSet {
			if isSelected != oldValue {
				photoImageView.alpha = isSelected ? alphaSelected : alphaNotSelected
			}
		}
	}
	
	func set(image: UIImage?) {
		photoImageView.image = image
	}
	
	override func prepareForReuse() {
		photoImageView.image = nil
	}
}
