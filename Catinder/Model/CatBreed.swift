//
//  CatBreed.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import Foundation

enum CatBreed: String {
	case maineCoon = "Мейн-кун"
	case norwegianForestCat = "Норвежская лесная кошка"
	
	var name: String {
		return rawValue
	}
}
