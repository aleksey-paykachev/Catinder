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
	let headerText: String
	let titleText: String
	let subtitleText: String
	
	private let imagesNames: [String]
	private(set) var activeImageIndex = 0
	
	init(cardId: String, imagesNames: [String], headerText: String, titleText: String, subtitleText: String) {
		self.cardId = cardId
		self.imagesNames = imagesNames
		self.headerText = headerText
		self.titleText = titleText
		self.subtitleText = subtitleText
	}
	
	var imagesCount: Int {
		imagesNames.count
	}
	
	var activeImageName: String? {
		guard imagesCount > 0 else { return nil }
		
		return imagesNames[activeImageIndex]
	}
	
	mutating func goToPreviousImage() {
		activeImageIndex = max(0, activeImageIndex - 1)
	}
	
	mutating func advanceToNextImage() {
		activeImageIndex = min(imagesCount - 1, activeImageIndex + 1)
	}
}
