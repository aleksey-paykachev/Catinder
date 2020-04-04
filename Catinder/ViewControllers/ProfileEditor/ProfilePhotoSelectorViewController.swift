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
	var images = ["car", "airplane", "printer", "gamecontroller", "folder", "paperplane", "bell", "car", "airplane", "printer", "gamecontroller", "folder", "paperplane", "bell", "car", "airplane", "printer", "gamecontroller", "folder", "paperplane", "bell"].map { UIImage(systemName: $0)! }
	
	private let layout = UICollectionViewFlowLayout()
	
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
		layout.itemSize = CGSize(width: 100, height: 100)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotoSelectorCell", for: indexPath) as! ProfilePhotoSelectorCell
		cell.set(image: images[indexPath.item])
		return cell
	}
	
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
