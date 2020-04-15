//
//  ProfilePhotoSelectorLayout.swift
//  Catinder
//
//  Created by Aleksey on 16.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfilePhotoSelectorLayout: UICollectionViewCompositionalLayout {

	init(spacing: CGFloat) {
		let section = Self.createSection(spacing: spacing)
		
		super.init(section: section)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private static func createSection(spacing: CGFloat) -> NSCollectionLayoutSection {
		#warning("Add spacing")

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

		return NSCollectionLayoutSection(group: mainGroup)
	}
}
