//
//  Match.swift
//  Catinder
//
//  Created by Aleksey on 28/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct Match {
	let matchDate: Date
	let profile1: Profile
	let profile2: Profile
	let lastMessage: Message?
}

extension Match: LastMessageViewModelRepresentable {

	var lastMessageViewModel: LastMessageViewModel {
		let loggedInProfile = AuthenticationManager.shared.loggedInUser
		let matchedProfile = profile1 == loggedInProfile ? profile2 : profile1
		
		return LastMessageViewModel(profileUid: matchedProfile.uid,
									profileName: matchedProfile.name,
									profileImageName: matchedProfile.photoName,
									message: lastMessage?.text ?? "")
	}
}
