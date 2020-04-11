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
	
	let photosNames: [String]
	private(set) var selectedPhotoIndex = 0
	
	init(name: String, description: String, photosNames: [String]) {
		self.name = name
		self.description = description
		self.photosNames = photosNames
	}
	
	var photosCount: Int {
		photosNames.count
	}
	
	var selectedPhotoName: String? {
		guard photosCount > 0 else { return nil }

		return photosNames[selectedPhotoIndex]
	}
	
	mutating func setPhotoAsSelected(at index: Int) {
		guard index >= 0, index < photosNames.count else { return }
		
		selectedPhotoIndex = index
	}
}
