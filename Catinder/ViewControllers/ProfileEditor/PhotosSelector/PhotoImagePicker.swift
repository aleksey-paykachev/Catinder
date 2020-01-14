//
//  PhotoImagePicker.swift
//  Catinder
//
//  Created by Aleksey on 15/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol PhotoImagePickerDelegate: class {
	func didFinishPicking(image: UIImage, for photoId: UInt8)
}

class PhotoImagePicker: UIImagePickerController {
	var photoId: UInt8?
	weak var photoSelectorDelegate: PhotoImagePickerDelegate?
	
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
