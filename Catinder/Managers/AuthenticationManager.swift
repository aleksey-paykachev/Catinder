//
//  AuthenticationManager.swift
//  Catinder
//
//  Created by Aleksey on 03.02.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

class AuthenticationManager {
	static var shared = AuthenticationManager()
	
	private init() {}
	
	private(set) var loggedInUser: Profile? = nil

	func login(with username: String, password: String, completion: @escaping (Result<Bool, Error>) -> ()) {
		// get logged-in user data from network
		// ...
		
		let profileUid = "0C4CF4A2-6A45-4275-9F29-28951C1A317A"

		DataManager.shared.getProfile(by: profileUid) { [weak self] result in
			switch result {
			case .failure(let error):
				completion(.failure(error))

			case .success(let profile):
				self?.loggedInUser = profile
				completion(.success(true))
			}
		}
	}
	
	func logout() {
		loggedInUser = nil
	}
	
//	enum Authentication
}
