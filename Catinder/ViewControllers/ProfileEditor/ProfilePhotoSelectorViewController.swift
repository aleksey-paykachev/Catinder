//
//  ProfilePhotoSelectorViewController.swift
//  Catinder
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfilePhotoSelectorViewController: UICollectionViewController {
	
	private let maximumPhotosCountPerProfile = 6

	private lazy var imagesNames: [String?] = {
		guard let loggedInUser = AuthenticationManager.shared.loggedInUser else { return [] }

		var userPhotosNames: [String?] = loggedInUser.photosNames
		return userPhotosNames.expandToCapacity(maximumPhotosCountPerProfile, with: nil)
	}()
	
	private let layout = ProfilePhotoSelectorLayout(spacing: 10)
	
	init() {
		super.init(collectionViewLayout: layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
	}
	
	private func setupCollectionView() {
		// drag and drop
		collectionView.dragInteractionEnabled = true
		collectionView.dragDelegate = self
		collectionView.dropDelegate = self
		
		collectionView.backgroundColor = .clear
		collectionView.register(ProfilePhotoSelectorCell.self, forCellWithReuseIdentifier: "ProfilePhotoSelectorCell")
	}
	
	private func showPhotoImagePickerSourceSelector(for photoId: Int) {
		let imageSourceSelectorAlertController = UIAlertController(title: "Пожалуйста, выберите действие.", message: nil, preferredStyle: .actionSheet)

		// if device have a camera, add it as an option for photo note image source selector
		if UIImagePickerController.isSourceTypeAvailable(.camera) {

			let addImageFromCameraAction = UIAlertAction(title: "Добавить с камеры", style: .default) { _ in
				let cameraPicker = PhotoImagePicker(photoId: photoId, delegate: self, source: .camera)
				self.present(cameraPicker, animated: true)
			}
			imageSourceSelectorAlertController.addAction(addImageFromCameraAction)
		}

		let addImageFromPhotoLibraryAction = UIAlertAction(title: "Выбрать из библиотеки", style: .default) { _ in
			let libraryPicker = PhotoImagePicker(photoId: photoId, delegate: self, source: .photoLibrary)
			self.present(libraryPicker, animated: true)
		}
		imageSourceSelectorAlertController.addAction(addImageFromPhotoLibraryAction)

		// add 'delete' option only if there is a photo in current slot
		if imagesNames[photoId] != nil {
			let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
				self.deletePhoto(at: photoId)
			}
			imageSourceSelectorAlertController.addAction(deleteAction)
		}

		let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
		imageSourceSelectorAlertController.addAction(cancelAction)

		present(imageSourceSelectorAlertController, animated: true)
	}
	
	func deletePhoto(at photoId: Int) {
		// delete image on server
		#warning("Send to server")
		
		// update data source
		imagesNames[photoId] = nil
		print(imagesNames)
		
		// update cell
		let indexPath = IndexPath(item: photoId, section: 0)
		collectionView.reloadItems(at: [indexPath])
	}
}


// MARK: - UICollectionViewDataSource

extension ProfilePhotoSelectorViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		imagesNames.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotoSelectorCell", for: indexPath) as! ProfilePhotoSelectorCell
		cell.set(imageName: imagesNames[indexPath.item])
		
		return cell
	}
}


// MARK: - UICollectionViewDelegate

extension ProfilePhotoSelectorViewController {

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		showPhotoImagePickerSourceSelector(for: indexPath.item)
	}
}


// MARK: - UICollectionViewDragDelegate

extension ProfilePhotoSelectorViewController: UICollectionViewDragDelegate {
	
	func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		
		// disable dragging of empty item
		guard let imageName = imagesNames[indexPath.item] else { return [] }
		
		let itemProvider = NSItemProvider(object: imageName as NSString)
		let item = UIDragItem(itemProvider: itemProvider)
		
		return [item]
	}
}


// MARK: - UICollectionViewDropDelegate

extension ProfilePhotoSelectorViewController: UICollectionViewDropDelegate {
	
	func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
		
		UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
	}

	func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
		
		guard let droppedItem = coordinator.items.first,
			  let sourceIndexPath = droppedItem.sourceIndexPath,
			  let destinationIndexPath = coordinator.destinationIndexPath else { return }

		// disable dropping on empty item
		if imagesNames[destinationIndexPath.item] == nil { return }
		
		collectionView.performBatchUpdates({
			let draggedImage = imagesNames.remove(at: sourceIndexPath.item)
			imagesNames.insert(draggedImage, at: destinationIndexPath.item)
			
			collectionView.deleteItems(at: [sourceIndexPath])
			collectionView.insertItems(at: [destinationIndexPath])
		})
		
		coordinator.drop(droppedItem.dragItem, toItemAt: destinationIndexPath)
	}
}


// MARK: - PhotoImagePickerDelegate

extension ProfilePhotoSelectorViewController: PhotoImagePickerDelegate {

	func didFinishPicking(image: UIImage, for photoId: Int) {
		// upload image to server
		DataManager.shared.setImage(image, at: photoId) { [weak self] imageName, error in
			if let error = error {
				print("Error: could not upload image to server.", error.localizedDescription)
			}

			// update data source
			self?.imagesNames[photoId] = imageName
		}
		
		// update cell
		let indexPath = IndexPath(item: photoId, section: 0)
		if let cell = collectionView.cellForItem(at: indexPath) as? ProfilePhotoSelectorCell {
			cell.set(image: image)
		}
	}
}
