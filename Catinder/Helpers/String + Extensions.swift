//
//  String + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 01.02.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

extension String {

	/// Returns a new string made by removing whitespaces and new lines characters from
	/// both ends of the String.
	///
	var trimmed: String {
		trimmingCharacters(in: .whitespacesAndNewlines)
	}
}
