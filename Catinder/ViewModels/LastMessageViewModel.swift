//
//  LastMessageViewModel.swift
//  Catinder
//
//  Created by Aleksey on 22/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

protocol LastMessageViewModelRepresentable {
	var lastMessageViewModel: LastMessageViewModel { get }
}

struct LastMessageViewModel {
	let profileName: String
	let profileImageName: String
	let message: String
}
