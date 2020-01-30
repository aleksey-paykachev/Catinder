//
//  ConversationViewControllerFlowLayout.swift
//  Catinder
//
//  Created by Aleksey on 30.01.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ConversationViewControllerFlowLayout: UICollectionViewFlowLayout {
	var insertingItemsIndexPaths: Set<IndexPath> = [] // inserting items by current update
	
	override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
		
		if insertingItemsIndexPaths.contains(itemIndexPath) {
			// add slide from bottom for newly inserted elements
			attributes?.transform = CGAffineTransform(translationX: 0, y: 200)
		}

		return attributes
	}
	
	override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
		super.prepare(forCollectionViewUpdates: updateItems)

		for item in updateItems where item.updateAction == .insert {
			guard let indexPath = item.indexPathAfterUpdate else { continue }

			insertingItemsIndexPaths.insert(indexPath)
		}
	}
	
	override func finalizeCollectionViewUpdates() {
		super.finalizeCollectionViewUpdates()
		
		insertingItemsIndexPaths.removeAll()
	}
}
