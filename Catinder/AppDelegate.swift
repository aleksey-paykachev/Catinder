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
		window?.rootViewController = CatinderNavigationController(rootViewController: CardsViewerViewController())

		window?.makeKeyAndVisible()
		
		#warning("Move auth logic from app delegate.")
		AuthenticationManager.shared.login(with: "login", password: "password")
		return true
	}
}
