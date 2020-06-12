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

	func login(with username: String, password: String, completion: @escaping (Result<Profile, Error>) -> ()) {
		
		#warning("Get logged-in profile from network instead of using hardcoded value.")
		let profileUid = "F98FBF08-0C94-4C67-97CB-D55DE82A5F47"

		DataManager.shared.getProfile(by: profileUid) { [weak self] result in
			switch result {
			case .failure(let error):
				completion(.failure(error))

			case .success(let profile):
				self?.loggedInUser = profile
				completion(.success(profile))
			}
		}
	}
	
	func logout() {
		loggedInUser = nil
	}	
}
