//
//  Array + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 18.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

extension Array {
	
	/// Expand current array to given capacity and fill it with provided elements.
	/// - Parameters:
	///   - capacity: The capacity of the array after expanding.
	///   - element: The value of the element to fill the new items of the expanded array.
	///
	mutating func expandToCapacity(_ capacity: Int, with element: Element) -> Self {
		let emptyElementsCount = capacity - count

		if emptyElementsCount > 0 {
			self += Array(repeating: element, count: emptyElementsCount)
		}
		
		return self
	}
}
