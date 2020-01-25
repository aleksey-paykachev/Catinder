//
//  ConversationMessageViewModel.swift
//  Catinder
//
//  Created by Aleksey on 25/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct ConversationMessageViewModel {
	let sender: Sender
	let message: String
	
	enum Sender {
		case user
		case collocutor
	}
}
