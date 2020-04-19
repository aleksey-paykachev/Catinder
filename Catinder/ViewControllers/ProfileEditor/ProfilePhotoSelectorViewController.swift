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
		print(indexPath)
		let photoImagePicker = PhotoImagePicker()
		photoImagePicker.photoId = 1
		present(photoImagePicker, animated: true)
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
