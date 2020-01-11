//
//  DogProfile.swift
//  Catinder
//
//  Created by Aleksey on 30/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct DogProfile: Profile {
	let uid = UUID().uuidString
	let name: String
	let photoName: String
	let description: String
}


// MARK: - CardViewModelRepresentable

extension DogProfile: CardViewModelRepresentable {
	var cardViewModel: CardViewModel {
		return CardViewModel(cardId: uid,
							 imagesNames: [photoName],
							 headerText: name,
							 titleText: "",
							 subtitleText: description)
	}
}


// MARK: - ProfileViewModelRepresentable

extension DogProfile: ProfileViewModelRepresentable {
	var profileViewModel: ProfileViewModel {
		return ProfileViewModel(name: name,
								description: description,
								photosNames: [photoName])
	}
}
