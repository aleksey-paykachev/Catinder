//
//  AuthenticationManager.swift
//  Catinder
//
//  Created by Aleksey on 03.02.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

protocol AuthenticationManagerDelegate: class {
	func userDidLogin()
	func userDidLogout()
}

class AuthenticationManager {
	static var shared = AuthenticationManager()
	
	private init() {}
	
	private(set) var loggedInUser: Profile? = nil
	weak var delegate: AuthenticationManagerDelegate?

	func login(with username: String, password: String, completion: @escaping (Result<Profile, Error>) -> ()) {
		
		DataManager.shared.login(username: username, password: password) { [weak self] result in
			switch result {
			case .failure(let error):
				completion(.failure(error))

			case .success(let loginData) where loginData.result == true:
				guard let profile = loginData.profile else {
					completion(.failure(AuthenticationError.noProfileData))
					return
				}

				self?.loggedInUser = profile
				self?.delegate?.userDidLogin()
				completion(.success(profile))
				
			default:
				completion(.failure(AuthenticationError.wrongAuthenticationData))
			}
		}
	}
	
	func logout() {
		loggedInUser = nil
		delegate?.userDidLogout()
	}
	
	
	// MARK: - Errors
	
	enum AuthenticationError: Swift.Error {
		case noProfileData
		case wrongAuthenticationData
	}
}
