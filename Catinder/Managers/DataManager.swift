//
//  DataManager.swift
//  Catinder
//
//  Created by Aleksey on 09/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class DataManager {
	// MARK: - Properties

	static let shared = DataManager()

	private let networkManager = NetworkManager()
	private let jsonDecoder = JSONDecoder()

	
	// MARK: - Init
	
	private init() { } 	// Singleton
	
	
	// MARK: - Profiles
	
	func getAllProfiles(completion: @escaping ([Profile]?, Error?) -> ()) {
		parseDataFromNetwork(for: "profiles", completion: completion)
	}
	
	func getProfile(by uid: String, completion: @escaping (Profile?, Error?) -> ()) {
		parseDataFromNetwork(for: "profile/\(uid)", completion: completion)
	}
	
	
	// MARK: - Images
	
	func getImage(name: String, completion: @escaping (UIImage?, Error?) -> ()) {

		networkManager.getImageData(imageName: name) { data, error in
			if let error = error {
				completion(nil, error)
				return
			}
			
			guard let data = data, let image = UIImage(data: data) else {
				completion(nil, DataManagerError.wrongData)
				return
			}
			
			completion(image, nil)
		}
	}
	
	func setImage(_ image: UIImage, at position: Int, completion: @escaping (String?, Error?) -> ()) {
		// emulate uploading image and recieving new image name from server
		let responseDelay = Int.random(in: 500...1000)

		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			let imageName = UUID().uuidString + ".jpg"
			completion(imageName, nil)
		}
	}
	
	func deleteImage(at position: Int, completion: @escaping (Result<Bool, Error>) -> ()) {
		// emulate deleting image from server
		let responseDelay = Int.random(in: 500...1000)

		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion(.success(true))
		}
	}
	
	
	// MARK: - Matches

	func getMatches(completion: @escaping ([Match]?, Error?) -> ()) {

		// Emulate server response
		let responseDelay = Int.random(in: 500...1500)
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion(self.demoMatches, nil)
		}
	}
	
	
	// MARK: - Messages
	
	func getMessages(forConversationWith collocutorUid: String, completion: @escaping ([Message]?, Error?) -> ()) {

		// emulate server response
		let responseDelay = Int.random(in: 500...1500)
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion(self.demoMessages, nil)
		}
	}
	
	func addMessage(forConversationWith collocutorUid: String, completion: ((Bool?, Error?) -> ())? = nil) {

		// emulate server request
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
		case wrongData
		case parseError
		
		var errorDescription: String? {
			switch self {
			case .emptyData:
				return "Recieve empty data."
			case .wrongData:
				return "Recieve wrong data."
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

		let marusia = Profile(uid: "95387C7D-E2EA-4E99-95C6-CA51E1F2B9BF", name: "Маруся", age: 4, photosNames: ["Marusia.jpg"], description: "")
		let stray = Profile(uid: "B99E5E82-70BF-47E4-A2C8-41B4829DAF62", name: "Мамочка", age: 3, photosNames: ["Mamochka.jpg"], description: "")
		
		let message = Message(date: Date(), senderUid: "-", receiverUid: "-", text: "Привет.")

		return [
			Match(matchDate: Date(), profile1: user, profile2: marusia, lastMessage: message),
			Match(matchDate: Date(), profile1: stray, profile2: user, lastMessage: message)
		]
	}
}
