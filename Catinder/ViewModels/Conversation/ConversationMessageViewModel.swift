//
//  ConversationMessageViewModel.swift
//  Catinder
//
//  Created by Aleksey on 25/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

protocol ConversationMessageViewModelRepresentable {
	var conversationMessageViewModel: ConversationMessageViewModel { get }
}

struct ConversationMessageViewModel {
	let sender: Sender
	let messageText: String
	let status: Message.Status
	
	enum Sender {
		case user
		case collocutor
	}
}
