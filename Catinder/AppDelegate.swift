//
//  AppDelegate.swift
//  Catinder
//
//  Created by Aleksey on 28/12/2019.
//  Copyright © 2019 Aleksey Paykachev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow()
		let cardsViewController = CardsViewerViewController()
//		let profileDataNavigationController = ProfileDataNavigationController()
		window?.rootViewController = cardsViewController
		window?.makeKeyAndVisible()
		
		return true
	}
}
