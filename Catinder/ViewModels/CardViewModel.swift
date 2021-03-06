//
//  CardViewModel.swift
//  Catinder
//
//  Created by Aleksey on 03/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

protocol CardViewModelRepresentable {
	var cardViewModel: CardViewModel { get }
}

struct CardViewModel {
	let cardId: String
	let title: String
	let content: String
	
	private let imagesNames: [String]
	private(set) var activeImageIndex = 0
	
	init(cardId: String, imagesNames: [String], title: String, content: String) {
		self.cardId = cardId
		self.imagesNames = imagesNames
		self.title = title
		self.content = content
	}
	
	var imagesCount: Int {
		imagesNames.count
	}
	
	var activeImageName: String? {
		guard imagesCount > 0 else { return nil }
		
		return imagesNames[activeImageIndex]
	}
	
	@discardableResult mutating func goToPreviousImage() -> Bool {
		let newImageIndex = max(0, activeImageIndex - 1)
		
		if activeImageIndex != newImageIndex {
			activeImageIndex = newImageIndex
			return true
		}
		
		return false
	}
	
	@discardableResult mutating func advanceToNextImage() -> Bool {
		let newImageIndex = min(imagesCount - 1, activeImageIndex + 1)
		
		if activeImageIndex != newImageIndex {
			activeImageIndex = newImageIndex
			return true
		}
		
		return false
	}
}
