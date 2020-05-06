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

	@discardableResult func login(with username: String, password: String) -> Bool {
		// get logged-in user data from network
		// ...
		
		loggedInUser = Profile(uid: "F59C2433-B0F5-4A84-B017-2212C1CFA7ED", name: "Me", age: 5, photosNames: ["Bob_1.jpg", "Bob_2.jpg", "Bob_3.jpg"], shortDescription: "Some short description about myself.", extendedDescription: "Extended description could be distributed along multiple lines because it could be very long.")
		
		return true
	}
	
	func logout() {
		loggedInUser = nil
	}
}
