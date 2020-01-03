//
//  CardViewModel.swift
//  Catinder
//
//  Created by Aleksey on 03/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CardViewModelRepresentable {
	var viewModel: CardViewModel { get }
}

struct CardViewModel {
	let headerText: String
	let titleText: String
	let subtitleText: String
	
	private let imagesNames: [String]
	private(set) var activeImageIndex = 0
	
	init(imagesNames: [String], headerText: String, titleText: String, subtitleText: String) {
		self.imagesNames = imagesNames
		self.headerText = headerText
		self.titleText = titleText
		self.subtitleText = subtitleText
	}
	
	var numberOfImages: Int {
		return imagesNames.count
	}
	
	var activeImage: UIImage? {
		let imageName = imagesNames[activeImageIndex]
		return UIImage(named: imageName)
	}
	
	mutating func goToPreviousImage() {
		activeImageIndex = max(0, activeImageIndex - 1)
	}
	
	mutating func advanceToNextImage() {
		activeImageIndex = min(imagesNames.count - 1, activeImageIndex + 1)
	}
}
