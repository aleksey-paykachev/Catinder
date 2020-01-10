//
//  CatProfile.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct CatProfile: Profile {
	let uid = UUID().uuidString
	let name: String
	let age: Int
	let breed: CatBreed
	let photosNames: [String]
	let description: String
}


// MARK: - CardViewModelRepresentable

extension CatProfile: CardViewModelRepresentable {
	var viewModel: CardViewModel {
		return CardViewModel(cardId: uid,
							 imagesNames: photosNames,
							 headerText: "\(name), \(age)",
							 titleText: breed.name,
							 subtitleText: description)
	}
}
