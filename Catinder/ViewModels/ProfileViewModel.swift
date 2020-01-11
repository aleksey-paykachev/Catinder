//
//  ProfileViewModel.swift
//  Catinder
//
//  Created by Aleksey on 10/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

protocol ProfileViewModelRepresentable {
	var profileViewModel: ProfileViewModel { get }
}

struct ProfileViewModel {
	let name: String
	let description: String
	
	private let photosNames: [String]
	private(set) var activePhotoIndex = 0
	
	init(name: String, description: String, photosNames: [String]) {
		self.name = name
		self.description = description
		self.photosNames = photosNames
	}
	
	var photosCount: Int {
		return photosNames.count
	}
	
	var activePhotoName: String? {
		guard photosCount > 0 else { return nil }

		return photosNames[activePhotoIndex]
	}
	
	mutating func goToPreviousPhoto() {
		activePhotoIndex = max(0, activePhotoIndex - 1)
	}
	
	mutating func andvanceToNextPhoto() {
		activePhotoIndex = min(photosCount - 1, activePhotoIndex + 1)
	}
}
