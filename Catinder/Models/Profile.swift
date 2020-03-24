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
	let description: String
	
	var photoName: String {
		photosNames.first ?? ""
	}
	
	var shortDescription: String {
		description.count > 120 ? description.prefix(100).appending("...") : description
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
					  headerText: "\(name), \(age)",
					  titleText: "-----",
					  subtitleText: shortDescription)
	}
}


// MARK: - ProfileViewModelRepresentable

extension Profile: ProfileViewModelRepresentable {

	var profileViewModel: ProfileViewModel {
		ProfileViewModel(name: name,
						 description: description,
						 photosNames: photosNames)
	}
}
