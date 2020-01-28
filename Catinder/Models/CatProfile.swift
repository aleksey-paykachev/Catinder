//
//  CatProfile.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct CatProfile: Profile, Decodable {
	let uid: String
	let name: String
	let age: Int
	let breed: CatBreed
	let photosNames: [String]
	let description: String
	
	var photoName: String {
		return photosNames.first ?? ""
	}
}


// MARK: - CardViewModelRepresentable

extension CatProfile: CardViewModelRepresentable {
	var cardViewModel: CardViewModel {
		return CardViewModel(cardId: uid,
							 imagesNames: photosNames,
							 headerText: "\(name), \(age)",
							 titleText: breed.name,
							 subtitleText: shortDescription)
	}
}


// MARK: - ProfileViewModelRepresentable

extension CatProfile: ProfileViewModelRepresentable {
	var profileViewModel: ProfileViewModel {
		return ProfileViewModel(name: name,
								description: description,
								photosNames: photosNames)
	}
}
