//
//  RelationshipDecision.swift
//  Catinder
//
//  Created by Aleksey on 21/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

enum RelationshipDecision: Equatable {
	case dislike
	case like(type: LikeType)
	
	enum LikeType {
		case regular
		case `super`
	}
}
