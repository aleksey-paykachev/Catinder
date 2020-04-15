//
//  ProfilePhotoSelectorViewController.swift
//  Catinder
//
//  Created by Aleksey on 02.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfilePhotoSelectorViewController: UICollectionViewController {
	
	// demo images instead of user photos
	var images = ["person.badge.plus.fill", "person.crop.circle.badge.plus", "person.crop.circle.fill.badge.plus", "plus.square", "plus.square.fill", "plus.circle", "plus.circle.fill", "photo", "photo.fill", "photo.on.rectangle", "photo.fill.on.rectangle.fill"].map { UIImage(systemName: $0)! }
	
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
		6
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotoSelectorCell", for: indexPath) as! ProfilePhotoSelectorCell
		cell.set(image: images[indexPath.item])
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
		
		let image = images[indexPath.item]
		let itemProvider = NSItemProvider(object: image)
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
		
		collectionView.performBatchUpdates({
			let draggedImage = images.remove(at: sourceIndexPath.item)
			images.insert(draggedImage, at: destinationIndexPath.item)
			
			collectionView.deleteItems(at: [sourceIndexPath])
			collectionView.insertItems(at: [destinationIndexPath])
		})
		
		coordinator.drop(droppedItem.dragItem, toItemAt: destinationIndexPath)
	}
}
