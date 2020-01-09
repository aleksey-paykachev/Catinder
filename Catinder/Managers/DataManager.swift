//
//  DataManager.swift
//  Catinder
//
//  Created by Aleksey on 09/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import Foundation

#warning("Change local demo data fetching to network requests.")

class DataManager {
	static let shared = DataManager()
	
	// singleton
	private init() { }
	
	func getAllProfiles(completion: ([Profile], Error?) -> ()) {
		completion(profiles, nil)
	}
	
	func getProfile(by uid: String, completion: (Profile?, Error?) -> ()) {
		let profile = profiles.first { $0.uid == uid }
		
		completion(profile, nil)
	}
	
	private let profiles: [Profile] = [
		CatProfile(name: "Барсик", age: 3, breed: .maineCoon, photosNames: ["Cat_Barsik"], description: "Люблю драть мебель, и мяукать по ночам. Также очень люблю, когда мне чешут животик."),
		DogProfile(name: "Дружок", photoName: "Dog_Druzhok", description: "Люблю убивать людей."),
		CatProfile(name: "Маруся", age: 2, breed: .norwegianForestCat, photosNames: ["Cat_Marusia"], description: "Люблю с умным видом смотреть в окно, ожидая конца света."),
		CatProfile(name: "Боб", age: 10, breed: .unknown, photosNames: ["Cat_Bob_1", "Cat_Bob_2", "Cat_Bob_3"], description: "Про меня сняли фильм, и написали несколько книг. А чего добился ты?")
	]
}
