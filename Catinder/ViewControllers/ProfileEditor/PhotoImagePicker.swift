//
//  PhotoImagePicker.swift
//  Catinder
//
//  Created by Aleksey on 15/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol PhotoImagePickerDelegate: class {
	func didFinishPicking(image: UIImage, for photoId: Int)
}

class PhotoImagePicker: UIImagePickerController {
	private var photoId: Int?
	private weak var photoSelectorDelegate: PhotoImagePickerDelegate?
	
	convenience init(photoId: Int, delegate: PhotoImagePickerDelegate, source: SourceType) {
		self.init()
		
		self.photoId = photoId
		photoSelectorDelegate = delegate
		sourceType = source
		setup()
	}
	
	private func setup() {
		modalPresentationStyle = .fullScreen
		allowsEditing = true
		delegate = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegate = self
		allowsEditing = true
	}
}


// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension PhotoImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		if let image = info[.editedImage] as? UIImage, let photoId = photoId {
			photoSelectorDelegate?.didFinishPicking(image: image, for: photoId)
		}
		
		dismiss(animated: true)
	}
}
