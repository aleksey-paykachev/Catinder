//
//  NetworkEmulator.swift
//  Catinder
//
//  Created by Aleksey on 06.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

final class NetworkEmulator {
	
	/// Emulate network request with given response time.
	/// - Parameters:
	///   - response: Response time type of the emulated request
	///   - completion: Completion method to execute after emulated response delay.
	///
	static func emulateRequest(response: ResponseType, completion: @escaping () -> ()) {
		let responseDelay = Int.random(in: response.delayRange)

		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(responseDelay)) {
			completion()
		}
	}
	
	/// Response time type of the emulated request.
	///
	enum ResponseType {
		case fast
		case medium
		case long
		
		var delayRange: ClosedRange<Int> {
			switch self {
			case .fast:
				return 200...500
			case .medium:
				return 500...1000
			case .long:
				return 1000...1500
			}
		}
	}
}
