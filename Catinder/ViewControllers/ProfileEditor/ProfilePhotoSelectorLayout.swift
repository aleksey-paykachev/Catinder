//
//  ProfilePhotoSelectorLayout.swift
//  Catinder
//
//  Created by Aleksey on 16.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfilePhotoSelectorLayout: UICollectionViewCompositionalLayout {

	init(edgeSpacing: CGFloat = 0, interItemSpacing: CGFloat = 0) {
		let section = Self.createSection(edgeSpacing: edgeSpacing, interItemSpacing: interItemSpacing)
		
		super.init(section: section)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private static func createSection(edgeSpacing: CGFloat, interItemSpacing: CGFloat) -> NSCollectionLayoutSection {

		// large top-left main item
		let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.67), heightDimension: .fractionalHeight(1))
		let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
		largeItem.contentInsets.trailing = interItemSpacing

		// small right vertical items and group
		let verticalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
		let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
		
		let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
		let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalItem, count: 2)
		verticalGroup.interItemSpacing = .fixed(interItemSpacing)

		// top group (main item + right items)
		let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.67))
		let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [largeItem, verticalGroup])
		topGroup.contentInsets.bottom = interItemSpacing
		
		// small bottom-left horizontal items and group (below main item)
		let leftHorizontalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
		let leftHorizontalItem = NSCollectionLayoutItem(layoutSize: leftHorizontalItemSize)
		
		let leftHorizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.67), heightDimension: .fractionalHeight(1))
		let leftHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: leftHorizontalGroupSize, subitem: leftHorizontalItem, count: 2)
		leftHorizontalGroup.contentInsets.trailing = interItemSpacing
		leftHorizontalGroup.interItemSpacing = .fixed(interItemSpacing)
		
		// small bottom-right horizontal item
		let rightHorizontalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
		let rightHorizontalItem = NSCollectionLayoutItem(layoutSize: rightHorizontalItemSize)
		
		// bottom group (horizontal items)
		let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
		let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, subitems: [leftHorizontalGroup, rightHorizontalItem])
		
		// main group
		let mainGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
		let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: mainGroupSize, subitems: [topGroup, bottomGroup])
		mainGroup.contentInsets.leading = edgeSpacing
		mainGroup.contentInsets.trailing = edgeSpacing

		return NSCollectionLayoutSection(group: mainGroup)
	}
}
