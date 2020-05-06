//
//  Profile.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct Profile: Decodable {
	let uid: String
	let name: String
	let age: Int
	let photosNames: [String]
	let shortDescription: String
	let extendedDescription: String
	
	var photoName: String {
		photosNames.first ?? ""
	}
	
	var fullDescription: String {
		shortDescription + "/n" + extendedDescription
	}
}


// MARK: - Equatable

extension Profile: Equatable {

	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.uid == rhs.uid
	}
}


// MARK: - CardViewModelRepresentable

extension Profile: CardViewModelRepresentable {

	var cardViewModel: CardViewModel {
		CardViewModel(cardId: uid,
					  imagesNames: photosNames,
					  title: "\(name), \(age)",
					  content: shortDescription)
	}
}


// MARK: - ProfileViewModelRepresentable

extension Profile: ProfileViewModelRepresentable {

	var profileViewModel: ProfileViewModel {
		ProfileViewModel(name: name, description: fullDescription, photosNames: photosNames)
	}
}
