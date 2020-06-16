//
//  LoginData.swift
//  Catinder
//
//  Created by Aleksey on 16.06.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

struct LoginData: Decodable {
	let result: Bool
	let loginDate: Date?
	let profile: Profile?
}
