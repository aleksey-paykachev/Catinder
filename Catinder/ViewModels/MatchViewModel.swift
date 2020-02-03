//
//  MatchViewModel.swift
//  Catinder
//
//  Created by Aleksey on 21/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct MatchViewModel {
	let userProfileImageName = AuthenticationManager.shared.loggedInUser?.photoName ?? ""

	let matchedProfileName: String
	let matchedProfileImageName: String
}
