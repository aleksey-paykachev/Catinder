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
	
	private let layout = createLayout()
	
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
	
	private static func createLayout() -> UICollectionViewCompositionalLayout {
		// large item (main top-left item)
		let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1))
		let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)

		// small vertical items and group (right items)
		let smallVerticalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
		let smallVerticalItem = NSCollectionLayoutItem(layoutSize: smallVerticalItemSize)
		
		let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
		let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: smallVerticalItem, count: 2)

		// top group (main item + right items)
		let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.66))
		let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [largeItem, verticalGroup])
		
		// small horizontal items and group (bottom items)
		let smallHorizontalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
		let smallHorizontalItem = NSCollectionLayoutItem(layoutSize: smallHorizontalItemSize)
		
		let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.99), heightDimension: .fractionalHeight(0.33))
		let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitem: smallHorizontalItem, count: 3)
		
		// main group
		let mainGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
		let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: mainGroupSize, subitems: [topGroup, horizontalGroup])

		let section = NSCollectionLayoutSection(group: mainGroup)
		
		return UICollectionViewCompositionalLayout(section: section)
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
