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
	private let jsonDecoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .iso8601

		return jsonDecoder
	}()

	
	// MARK: - Init
	
	private init() { } 	// Singleton
	
	
	// MARK: - Profiles
	
	func getAllProfiles(completion: @escaping (Result<[Profile], Error>) -> ()) {
		parseDataFromNetwork(for: "profiles", completion: completion)
	}
	
	func getProfile(by uid: String, completion: @escaping (Result<Profile, Error>) -> ()) {
		parseDataFromNetwork(for: "profile/\(uid)", completion: completion)
	}
	
	
	// MARK: - Images
	
	func getImage(name: String, completion: @escaping (Result<UIImage, Error>) -> ()) {

		networkManager.getImageData(imageName: name) { result in
			
			switch result {
			case .failure(let networkError):
				completion(.failure(networkError))

			case .success(let data):
				guard let image = UIImage(data: data) else {
					completion(.failure(DataManagerError.wrongData))
					return
				}
				
				completion(.success(image))
			}
		}
	}
	
	func setImage(_ image: UIImage, at position: Int, completion: @escaping (Result<String, DataManagerError>) -> ()) {

		// emulate uploading image and recieving uploaded image name from server
		NetworkEmulator.emulateRequest(response: .medium) {
			let imageName = UUID().uuidString + ".jpg"
			completion(.success(imageName))
		}
	}
	
	func deleteImage(at position: Int, completion: @escaping (Result<Bool, DataManagerError>) -> ()) {

		// emulate deleting image from server
		NetworkEmulator.emulateRequest(response: .medium) {
			completion(.success(true))
		}
	}
	
	
	// MARK: - Matches

	func getMatches(completion: @escaping (Result<[Match], Error>) -> ()) {
		parseDataFromNetwork(for: "matches", completion: completion)
	}
	
	
	// MARK: - Messages
	
	func getMessages(forConversationWith collocutorUid: String, completion: @escaping (Result<[Message], Error>) -> ()) {
		parseDataFromNetwork(for: "messages/\(collocutorUid)", completion: completion)
	}
	
	func addMessage(forConversationWith collocutorUid: String, completion: ((Bool?, Error?) -> ())? = nil) {

		// emulate saving new message to server
		NetworkEmulator.emulateRequest(response: .long) {
			completion?(true, nil)
		}
	}

	
	// MARK: - Likes / dislikes
	
	func setLike(to uid: String, likeType: RelationshipDecision.LikeType, completion: (_ isLikeMutual: Bool?, Error?) -> ()) {
		// save and get from server info about like mutuality. In this demo app use random values based on like type
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
	
	private func parseDataFromNetwork<T: Decodable>(for resource: String, completion: @escaping (Result<T, Error>) -> ()) {
		
		networkManager.getData(for: resource) { result in
			
			switch result {
			case .failure(let networkError):
				completion(.failure(networkError))

			case .success(let data):
				guard let parsedData = try? self.jsonDecoder.decode(T.self, from: data) else {
					completion(.failure(DataManagerError.parseError))
					return
				}
				
				completion(.success(parsedData))
			}
		}
	}
	
	
	// MARK: - Errors
	
	enum DataManagerError: LocalizedError {
		case wrongData
		case parseError
		case imageUpdateError
		case imageDeleteError
		
		var errorDescription: String? {
			let errorHeader = "An error occured. Please try again later."
			let error: String

			switch self {
			case .wrongData:
				error = "Recieve wrong data."
			case .parseError:
				error = "Could not parse data."
			case .imageUpdateError:
				error = "Could not update image."
			case .imageDeleteError:
				error = "Could not delete image."
			}
			
			return errorHeader + "\n\n" + error
		}
	}
}
