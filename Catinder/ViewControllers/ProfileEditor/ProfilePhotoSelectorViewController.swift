//
//  PhotoSelectorViewController.swift
//  Catinder
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class PhotoSelectorViewController: UICollectionViewController {
	
	private let dataManager = DataManager.shared
	private let maximumPhotosCountPerProfile = 6

	private lazy var imagesNames: [String?] = {
		guard let loggedInUser = AuthenticationManager.shared.loggedInUser else { return [] }

		var userPhotosNames: [String?] = loggedInUser.photosNames
		return userPhotosNames.expandToCapacity(maximumPhotosCountPerProfile, with: nil)
	}()
	
	private let layout = PhotoSelectorLayout(edgeSpacing: 14, interItemSpacing: 10)
	
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
		collectionView.registerCell(PhotoSelectorCell.self)
	}
	
	private func showPhotoImagePickerSourceSelector(for photoId: Int) {
		let imageSourceSelectorAlertController = UIAlertController(title: "Пожалуйста, выберите действие.", message: nil, preferredStyle: .actionSheet)

		// if device have a camera, add it as an option for photo note image source selector
		if UIImagePickerController.isSourceTypeAvailable(.camera) {

			let addImageFromCameraAction = UIAlertAction(title: "Добавить с камеры", style: .default) { _ in
				let cameraPicker = CatinderImagePicker(imageId: photoId, delegate: self, source: .camera)
				self.present(cameraPicker, animated: true)
			}
			imageSourceSelectorAlertController.addAction(addImageFromCameraAction)
		}

		let addImageFromPhotoLibraryAction = UIAlertAction(title: "Выбрать из библиотеки", style: .default) { _ in
			let libraryPicker = CatinderImagePicker(imageId: photoId, delegate: self, source: .photoLibrary)
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
		let indexPath = IndexPath(item: photoId, section: 0)
		guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoSelectorCell else { return }

		// delete image on server
		cell.showActivityIndicator()

		dataManager.deleteImage(at: photoId) { [weak self, weak cell] result in
			switch result {
			case .success(_):
				self?.imagesNames[photoId] = nil
				cell?.set(image: nil)

			case .failure(let error):
				print("Error:", error.localizedDescription)
			}
		}
	}
}


// MARK: - UICollectionViewDataSource

extension PhotoSelectorViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		imagesNames.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueCell(PhotoSelectorCell.self, for: indexPath)
		
		if let imageName = imagesNames[indexPath.item] {
			// download image from server
			cell.showActivityIndicator()

			DataManager.shared.getImage(name: imageName) { [weak cell] image, _ in
				cell?.set(image: image)
			}
		} else {
			cell.set(image: nil)
		}
		
		return cell
	}
}


// MARK: - UICollectionViewDelegate

extension PhotoSelectorViewController {

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		showPhotoImagePickerSourceSelector(for: indexPath.item)
	}
}


// MARK: - UICollectionViewDragDelegate

extension PhotoSelectorViewController: UICollectionViewDragDelegate {
	
	func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		
		// disable dragging of empty item
		guard let imageName = imagesNames[indexPath.item] else { return [] }
		
		let itemProvider = NSItemProvider(object: imageName as NSString)
		let item = UIDragItem(itemProvider: itemProvider)
		
		return [item]
	}
}


// MARK: - UICollectionViewDropDelegate

extension PhotoSelectorViewController: UICollectionViewDropDelegate {
	
	func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
		
		UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
	}

	func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
		
		guard let droppedItem = coordinator.items.first,
			  let sourceIndexPath = droppedItem.sourceIndexPath,
			  let destinationIndexPath = coordinator.destinationIndexPath else { return }

		collectionView.performBatchUpdates({
			let draggedImage = imagesNames.remove(at: sourceIndexPath.item)
			imagesNames.insert(draggedImage, at: destinationIndexPath.item)
			
			collectionView.deleteItems(at: [sourceIndexPath])
			collectionView.insertItems(at: [destinationIndexPath])
		})
		
		coordinator.drop(droppedItem.dragItem, toItemAt: destinationIndexPath)
	}
}


// MARK: - CatinderImagePickerDelegate

extension PhotoSelectorViewController: CatinderImagePickerDelegate {

	func didFinishPicking(image: UIImage, for photoId: Int) {
		let indexPath = IndexPath(item: photoId, section: 0)
		guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoSelectorCell else { return }
		
		// upload image to server
		cell.showActivityIndicator()
		
		dataManager.setImage(image, at: photoId) { [weak self, weak cell] result in
			switch result {
			case .success(let imageName):
				self?.imagesNames[photoId] = imageName
				cell?.set(image: image)
	
			case .failure(let error):
				print("Error:", error.localizedDescription)
			}
		}
	}
}
