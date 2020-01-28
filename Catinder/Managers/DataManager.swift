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
	
	var loggedInUserUid: String {
		return "Logged-In-User-Uid"
	}
	
	var loggedInUser: Profile {
		return CatProfile(uid: loggedInUserUid, name: "Me", age: 5, breed: .unknown, photosNames: [], description: "Description")
	}
	
	func getAllProfiles(completion: @escaping ([CatProfile]?, Error?) -> ()) {
		parseDataFromNetwork(for: "profiles", completion: completion)
	}
	
	func getMatchedProfiles(completion: ([CatProfile]?, Error?) -> ()) {
	}
	
	func getProfile(by uid: String, completion: @escaping (CatProfile?, Error?) -> ()) {
		parseDataFromNetwork(for: "profile/\(uid)", completion: completion)
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
	
	
	// MARK: - Network
	
	private func parseDataFromNetwork<T: Decodable>(for resource: String, completion: @escaping (T?, Error?) -> ()) {
		
		networkManager.getData(for: resource) { data, error in
			guard error == nil else {
				completion(nil, error)
				return
			}
			
			guard let data = data else {
				completion(nil, DataManagerError.emptyData)
				return
			}
			
			guard let parsedData = try? self.jsonDecoder.decode(T.self, from: data) else {
				completion(nil, DataManagerError.parseError)
				return
			}
			
			completion(parsedData, nil)
		}
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
