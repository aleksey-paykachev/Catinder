//
//  NetworkManager.swift
//  Catinder
//
//  Created by Aleksey on 27/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

class NetworkManager {
	
	private let serverApiUrl = "https://raw.githubusercontent.com/aleksey-paykachev/Catinder-Demo-Server/master/api/v1/"
	private let serverImagesUrl = "https://raw.githubusercontent.com/aleksey-paykachev/Catinder-Demo-Server/master/images/"

	
	// MARK: - Methods
	
	func getData(for apiResource: String, completionQueue: DispatchQueue = .main, completion: @escaping (Data?, Error?) -> ()) {

		guard let url = URL(string: serverApiUrl + apiResource) else {
			completionQueue.async {
				completion(nil, NetworkError.wrongUrl)
			}
			return
		}

		getData(from: url, completionQueue: completionQueue, completion: completion)
	}
	
	func getImageData(imageName: String, completionQueue: DispatchQueue = .main, completion: @escaping (Data?, Error?) -> ()) {
		
		guard let url = URL(string: serverImagesUrl + imageName) else {
			completionQueue.async {
				completion(nil, NetworkError.wrongUrl)
			}
			return
		}
		
		getData(from: url, completionQueue: completionQueue, completion: completion)
	}
	
	func getData(from url: URL, completionQueue: DispatchQueue = .main, completion: @escaping (Data?, Error?) -> ()) {

		URLSession.shared.dataTask(with: url) { data, urlResponse, error in
			let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode
			guard statusCode == 200 else {
				completionQueue.async {
					completion(nil, NetworkError.wrongStatusCode(statusCode))
				}
				return
			}

			completionQueue.async {
				completion(data, error)
			}
		}.resume()
	}
	
	
	// MARK: - Errors
	
	enum NetworkError: LocalizedError {
		case wrongUrl
		case wrongStatusCode(Int?)
		
		var errorDescription: String? {
			switch self {
			case .wrongUrl:
				return "Wrong URL."
			case .wrongStatusCode(let code):
				let codeDescription = code.map { String($0) } ?? "no code"
				return "Wrong HTTP status code. Expected: 200, get: \(codeDescription)."
			}
		}
	}
}
