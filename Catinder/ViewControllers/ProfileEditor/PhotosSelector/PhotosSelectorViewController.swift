//
//  PhotosSelectorViewController.swift
//  Catinder
//
//  Created by Aleksey on 15/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotosSelectorViewController: UIViewController {

	private let numberOfPhotos = 3
	private let photosInterItemSpacing: CGFloat = 10

	private lazy var photoImagePicker = PhotoImagePicker()

	private lazy var photoButtons = (0..<numberOfPhotos).map {
		PhotoSelectorButton(photoId: $0, tapCallback: { [weak self] photoId in
			self?.photoSelectorButtonDidTapped(photoId: photoId)
		})
	}
	
	override func loadView() {
		view = createView()
	}
	
	private func createView() -> UIView {
		let view = UIView()
		
		// secondary photos on the right side
		let secondaryStackView = UIStackView(arrangedSubviews: Array(photoButtons.dropFirst()))
		secondaryStackView.axis = .vertical
		secondaryStackView.distribution = .fillEqually
		secondaryStackView.spacing = photosInterItemSpacing
		
		// main photo on the left side
		let mainStackView = UIStackView(arrangedSubviews: [photoButtons[0], secondaryStackView])
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
	}
	
	private func photoSelectorButtonDidTapped(photoId: Int) {
		photoImagePicker.photoId = photoId
		present(photoImagePicker, animated: true)
	}
}


// MARK: - PhotoImagePickerDelegate

extension PhotosSelectorViewController: PhotoImagePickerDelegate {
	func didFinishPicking(image: UIImage, for photoId: Int) {
		photoButtons[photoId].setImage(image, for: .normal)
	}
}
