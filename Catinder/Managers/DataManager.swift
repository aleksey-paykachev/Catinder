//
//  DataManager.swift
//  Catinder
//
//  Created by Aleksey on 09/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

class DataManager {
	// MARK: - Properties

	static let shared = DataManager()

	private let networkManager = NetworkManager()
	private let jsonDecoder = JSONDecoder()

	
	// MARK: - Init
	
	private init() { } 	// Singleton
	
	
	// MARK: - Profiles
	
	func getAllProfiles(completion: @escaping ([Profile], Error?) -> ()) {

		networkManager.getData(for: "profiles") { data, error in
			guard error == nil else {
				completion([], error)
				return
			}
			
			guard let data = data else {
				completion([], DataManagerError.emptyData)
				return
			}
			
			guard let profiles = try? self.jsonDecoder.decode([CatProfile].self, from: data) else {
				completion([], DataManagerError.parseError)
				return
			}
			
			completion(profiles, nil)
		}
	}
	
	func getMatchedProfiles(completion: ([Profile], Error?) -> ()) {
	}
	
	func getProfile(by uid: String, completion: @escaping (Profile?, Error?) -> ()) {
		
		networkManager.getData(for: "profile/\(uid)") { data, error in
			guard error == nil else {
				completion(nil, error)
				return
			}
			
			guard let data = data else {
				completion(nil, DataManagerError.emptyData)
				return
			}
			
			guard let profile = try? self.jsonDecoder.decode(CatProfile.self, from: data) else {
				completion(nil, DataManagerError.parseError)
				return
			}
			
			completion(profile, nil)
		}
	}
	
	
	// MARK: - Messages
	
	#warning("Remove viewModel from Data Manager.")
	func getLastMessages(completion: @escaping ([LastMessageViewModel], Error?) -> ()) {

		// Emulate server request
		let responseDelay = Int.random(in: 500...1500)
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion(self.demoLastMessages, nil)
		}
	}
	
	#warning("Remove viewModel from Data Manager.")
	func getConversationMessages(for collocutorUid: String, completion: @escaping ([ConversationMessageViewModel], Error?) -> ()) {

		// Emulate server request
		let responseDelay = Int.random(in: 500...1500)
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion(self.demoConversationMessages, nil)
		}
	}

	
	// MARK: - Likes / dislikes
	
	func setLike(to uid: String, likeType: RelationshipDecision.LikeType, completion: (_ isLikeMutual: Bool?, Error?) -> ()) {
		// save to server
		// ...
		
		// and get from server info about like mutuality. In this demo app use random values based on like type
		let isLikeMutual: Bool

		switch likeType {
		case .regular:
			// regular like gives random probability of mutuality
			let mutualLikePercentageProbability = 35
			isLikeMutual = Int.random(in: 1...100) <= mutualLikePercentageProbability

		case .super:
			// super like always gives 100% probability of mutuality
			isLikeMutual = true
		}
		completion(isLikeMutual, nil)
	}
	
	func setDislike(to uid: String, completion: ((Error?) -> ())? = nil) {
		// save to server
		// ...

		completion?(nil)
	}
	
	
	// MARK: - Errors
	
	enum DataManagerError: LocalizedError {
		case emptyData
		case parseError
		
		var errorDescription: String? {
			switch self {
			case .emptyData:
				return "Empty data set."
			case .parseError:
				return "Could not parse data."
			}
		}
	}
	
	
	// MARK: - del - Demo data
	
	private let demoLastMessages = [
		LastMessageViewModel(profileName: "Маруся", profileImageName: "Cat_Marusia", message: "Привет."),
		LastMessageViewModel(profileName: "Мамочка", profileImageName: "Cat_Stray", message: "Пойдёшь со мной на дело? Надо у фраера одного скатерку спереть."),
		LastMessageViewModel(profileName: "Дружок", profileImageName: "Dog_Druzhok", message: "Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!\nГав! Гав! Гав! Гав! Гав! Гав! Гав! Гав!")
	]
	
	
	private let demoConversationMessages = [
		ConversationMessageViewModel(sender: .collocutor, message: "Привет."),
		ConversationMessageViewModel(sender: .user, message: "Привет, привет.\nКак у тебя дела?"),
		ConversationMessageViewModel(sender: .collocutor, message: "Да вот, решил написать тебе длинное сообщение, чтобы проверить, будет ли оно переноситься на следующую строку, чтобы целиком влезть на экран.")
	]
}
