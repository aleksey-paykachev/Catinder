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
	
	// Singleton
	private init() { }
	
	func getAllProfiles(completion: ([Profile], Error?) -> ()) {
		completion(profiles, nil)
	}
	
	func getMatchedProfiles(completion: ([Profile], Error?) -> ()) {
		completion(profiles, nil)
	}
	
	func getProfile(by uid: String, completion: (Profile?, Error?) -> ()) {
		let profile = profiles.first { $0.uid == uid }
		
		completion(profile, nil)
	}
	
	func setLike(to uid: String, likeType: RelationshipDecision.LikeType, completion: (_ isLikeMutual: Bool?, Error?) -> ()) {
		// save to server
		// ...
		
		// and get from server info about like mutuality. In this demo app use random values based on like type
		let isLikeMutual: Bool

		switch likeType {
		case .regular:
			// regular like gives random probability of mutuality
			let mutualLikePercentageProbability = 35
			isLikeMutual = Int.random(in: 1...100) <= mutualLikePercentageProbability

		case .super:
			// super like always gives 100% probability of mutuality
			isLikeMutual = true
		}
		completion(isLikeMutual, nil)
	}
	
	func setDislike(to uid: String, completion: ((Error?) -> ())? = nil) {
		// save to server
		// ...

		completion?(nil)
	}
	
	private let profiles: [Profile] = [
		CatProfile(name: "Барсик", age: 3, breed: .maineCoon, photosNames: ["Cat_Barsik"], description: "Люблю драть мебель, и мяукать по ночам. Также очень люблю, когда мне чешут животик."),
		DogProfile(name: "Дружок", photoName: "Dog_Druzhok", description: "Люблю убивать людей."),
		CatProfile(name: "Маруся", age: 2, breed: .norwegianForestCat, photosNames: ["Cat_Marusia"], description: "Люблю с умным видом смотреть в окно, ожидая конца света."),
		CatProfile(name: "Боб", age: 10, breed: .unknown, photosNames: ["Cat_Bob_1", "Cat_Bob_2", "Cat_Bob_3"], description: "Про меня сняли фильм, и написали несколько книг. А чего добился ты?"),
		CatProfile(name: "Мамочка", age: 3, breed: .unknown, photosNames: ["Cat_Stray"], description: """
Я уличный кот. У меня четыре ноги, а позади у меня длинный хвост.
Судьба моя печальна, а жизнь моя пропитана грустью. Позвольте я изложу свою историю в песне:


По приютам я с детства скитался,
Не имея родного угла...
Ах, зачем я на свет появился,
Ах, зачем меня мать родила...

А когда из приюта я вышел,
То пошёл себе дом я искать...
Стороной меня все обходили,
И никто не хотел к себе брать.

И пошел я по свету скитаться,
По квартирам я начал шмонать.
По чужим, по буржуйским квартирам
Стал котлеты и мясо сшибать.

Осторожный хозяин попался,
Меня за ухо цепко схватил...
Тут недолго судья разбирался
И в зверинец меня засадил!

Из тюрьмы я, котёнок, сорвался
И опять не имею угла...
Ах, зачем я на свет появился,
Ах, зачем меня мать родила!
""")
	]
}
