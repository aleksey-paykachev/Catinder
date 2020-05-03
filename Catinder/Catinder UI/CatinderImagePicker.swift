//
//  CatinderImagePicker.swift
//  Catinder
//
//  Created by Aleksey on 15/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CatinderImagePickerDelegate: class {
	func didFinishPicking(image: UIImage, for imageId: Int)
}

class CatinderImagePicker: UIImagePickerController {
	private var imageId: Int?
	private weak var imageSelectorDelegate: CatinderImagePickerDelegate?
	
	convenience init(imageId: Int, delegate: CatinderImagePickerDelegate, source: SourceType) {
		self.init()
		
		self.imageId = imageId
		imageSelectorDelegate = delegate
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

extension CatinderImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		if let image = info[.editedImage] as? UIImage, let imageId = imageId {
			imageSelectorDelegate?.didFinishPicking(image: image, for: imageId)
		}
		
		dismiss(animated: true)
	}
}
