//
//  Message.swift
//  Catinder
//
//  Created by Aleksey on 28/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct Message: Decodable {
	let date: Date
	let senderUid: String
	let receiverUid: String
	let text: String
}


// MARK: - ConversationMessageViewModelRepresentable

extension Message: ConversationMessageViewModelRepresentable {
	
	var conversationMessageViewModel: ConversationMessageViewModel {
		let loggedInUserUid = AuthenticationManager.shared.loggedInUser?.uid
		let sender = senderUid == loggedInUserUid ? ConversationMessageViewModel.Sender.user : .collocutor
		
		return ConversationMessageViewModel(sender: sender, messageText: text)
	}
}
