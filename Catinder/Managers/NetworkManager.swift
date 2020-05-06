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
	
	private let cache = NSCache<NSURL, NSData>()

	
	// MARK: - Convenience methods
	
	func getData(for apiResource: String, completionQueue: DispatchQueue = .main, completion: @escaping (Data?, NetworkError?) -> ()) {

		let urlString = serverApiUrl + apiResource
		getData(from: urlString, completionQueue: completionQueue, completion: completion)
	}
	
	func getImageData(imageName: String, completionQueue: DispatchQueue = .main, completion: @escaping (Data?, NetworkError?) -> ()) {
		
		let urlString = serverImagesUrl + imageName
		getData(from: urlString, completionQueue: completionQueue, completion: completion)
	}
	
	
	// MARK: - Main methods
	
	func getData(from urlString: String, completionQueue: DispatchQueue = .main, completion: @escaping (Data?, NetworkError?) -> ()) {
		
		guard let url = URL(string: urlString) else {
			completionQueue.async {
				completion(nil, NetworkError.wrongUrl)
			}
			return
		}
		
		getData(from: url, completionQueue: completionQueue, completion: completion)
	}
	
	func getData(from url: URL, completionQueue: DispatchQueue = .main, completion: @escaping (Data?, NetworkError?) -> ()) {
		
		// check if cache contains data for requested url
		if let cachedData = cache.object(forKey: url as NSURL) as Data? {
			completion(cachedData, nil)
			return
		}

		URLSession.shared.dataTask(with: url) { data, urlResponse, error in
			if let error = error {
				completionQueue.async {
					completion(nil, NetworkError.requestFailed(error: error))
				}
				return
			}
			
			let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode
			guard statusCode == 200 else {
				completionQueue.async {
					completion(nil, NetworkError.wrongStatusCode(statusCode))
				}
				return
			}

			// put recieved data into cache
			if let data = data {
				self.cache.setObject(data as NSData, forKey: url as NSURL)
			}
			
			completionQueue.async {
				completion(data, nil)
			}
		}.resume()
	}
	
	
	// MARK: - Errors
	
	enum NetworkError: LocalizedError {
		case wrongUrl
		case requestFailed(error: Error)
		case wrongStatusCode(Int?)
		
		var errorDescription: String? {
			let errorHeader = "Couldn't load data from server. Please try again later."
			let error: String
			
			switch self {
			case .wrongUrl:
				error = "Wrong URL."
				
			case .requestFailed:
				error = "Network request did failed."
				
			case .wrongStatusCode(let code):
				let codeDescription = code.map { String($0) } ?? "no code"
				error = "Wrong HTTP status code. Expected: 200, get: \(codeDescription)."
			}
			
			return errorHeader + "\n\n" + error
		}
	}
}
