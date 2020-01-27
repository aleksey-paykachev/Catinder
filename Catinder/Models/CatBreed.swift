//
//  CatBreed.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import Foundation

enum CatBreed: String, Decodable {
	case maineCoon
	case norwegianForestCat
	case unknown
	
	var name: String {
		switch self {
		case .unknown: return ""
		case .maineCoon: return "Мейн-кун"
		case .norwegianForestCat: return "Норвежская лесная кошка"
		}
	}
}
