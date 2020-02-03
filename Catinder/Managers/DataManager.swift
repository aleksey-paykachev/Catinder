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
	
	func getAllProfiles(completion: @escaping ([CatProfile]?, Error?) -> ()) {
		parseDataFromNetwork(for: "profiles", completion: completion)
	}
	
	func getProfile(by uid: String, completion: @escaping (CatProfile?, Error?) -> ()) {
		parseDataFromNetwork(for: "profile/\(uid)", completion: completion)
	}
	
	
	// MARK: - Matches

	func getMatches(completion: @escaping ([Match]?, Error?) -> ()) {

		// Emulate server request
		let responseDelay = Int.random(in: 500...1500)
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion(self.demoMatches, nil)
		}
	}
	
	
	// MARK: - Messages
	
	func getMessages(forConversationWith collocutorUid: String, completion: @escaping ([Message]?, Error?) -> ()) {

		// Emulate server request
		let responseDelay = Int.random(in: 500...1500)
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion(self.demoMessages, nil)
		}
	}
	
	func addMessage(forConversationWith collocutorUid: String, completion: ((Bool?, Error?) -> ())? = nil) {

		// Emulate server request
		let responseDelay = Int.random(in: 500...1500)
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion?(true, nil)
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
	
	
	// MARK: - Parser
	
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
	
	private let demoMessages = [
		Message(date: Date(), senderUid: "F59C2433-B0F5-4A84-B017-2212C1CFA7ED", receiverUid: "Logged-In-User-Uid", text: "Привет."),
		Message(date: Date(), senderUid: "Logged-In-User-Uid", receiverUid: "F59C2433-B0F5-4A84-B017-2212C1CFA7ED", text: "Привет, привет.\nКак у тебя дела?"),
		Message(date: Date(), senderUid: "F59C2433-B0F5-4A84-B017-2212C1CFA7ED", receiverUid: "Logged-In-User-Uid", text: "Да вот, решил написать тебе длинное сообщение, чтобы проверить, будет ли оно переноситься на следующую строку, чтобы целиком влезть на экран.")
	]
	
	private var demoMatches: [Match] {
		guard let user = AuthenticationManager.shared.loggedInUser else { return [] }

		let marusia = CatProfile(uid: "1", name: "Маруся", age: 4, breed: .unknown, photosNames: ["Cat_Marusia"], description: "")
		let stray = CatProfile(uid: "2", name: "Мамочка", age: 3, breed: .unknown, photosNames: ["Cat_Stray"], description: "")
		
		let message = Message(date: Date(), senderUid: "2", receiverUid: "1", text: "Привет.")

		return [
			Match(matchDate: Date(), profile1: user, profile2: marusia, lastMessage: message),
			Match(matchDate: Date(), profile1: stray, profile2: user, lastMessage: message)
		]
	}
}
