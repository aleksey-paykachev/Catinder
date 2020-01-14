//
//  PhotosSelectorViewController.swift
//  Catinder
//
//  Created by Aleksey on 15/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotosSelectorViewController: UIViewController {
	
	let photoImagePicker = PhotoImagePicker()
	let primaryImageButton = PhotoSelectorButton(photoId: 0)
	let secondaryImageButton1 = PhotoSelectorButton(photoId: 1)
	let secondaryImageButton2 = PhotoSelectorButton(photoId: 2)
	
	let photosInterItemSpacing: CGFloat = 10
	
	override func loadView() {
		view = createView()
	}
	
	private func createView() -> UIView {
		let view = UIView()
		
		// two secondary photos on the right side
		let secondaryStackView = UIStackView(arrangedSubviews: [secondaryImageButton1, secondaryImageButton2])
		secondaryStackView.axis = .vertical
		secondaryStackView.distribution = .fillEqually
		secondaryStackView.spacing = photosInterItemSpacing
		
		// main photo on the left side
		let mainStackView = UIStackView(arrangedSubviews: [primaryImageButton, secondaryStackView])
		mainStackView.axis = .horizontal
		mainStackView.distribution = .fillEqually
		mainStackView.spacing = photosInterItemSpacing
		
		view.addSubview(mainStackView)
		mainStackView.constrainToSuperview(paddings: .all(16))
		
		return view
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		photoImagePicker.photoSelectorDelegate = self
		
		#warning("Move target-action setup into PhotoSelectorButton.")
		primaryImageButton.addTarget(self, action: #selector(photoSelectorButtonDidTaped), for: .touchUpInside)
		secondaryImageButton1.addTarget(self, action: #selector(photoSelectorButtonDidTaped), for: .touchUpInside)
		secondaryImageButton2.addTarget(self, action: #selector(photoSelectorButtonDidTaped), for: .touchUpInside)
	}
	
	@objc private func photoSelectorButtonDidTaped(button: PhotoSelectorButton) {
		photoImagePicker.photoId = button.photoId
		present(photoImagePicker, animated: true)
	}
}


// MARK: - PhotoImagePickerDelegate

extension PhotosSelectorViewController: PhotoImagePickerDelegate {
	func didFinishPicking(image: UIImage, for photoId: UInt8) {
		print("Select photo for id:", photoId)
	}
}
