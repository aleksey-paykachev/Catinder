//
//  Profile.swift
//  Catinder
//
//  Created by Aleksey on 09/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

protocol Profile {
	var uid: String { get }
	var name: String { get }
	var description: String { get }
}

extension Profile {
	var shortDescription: String {
		return description.count > 120 ? description.prefix(100).appending("...") : description
	}
}
