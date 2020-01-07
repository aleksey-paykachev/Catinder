//
//  ProfileDataNavigationController.swift
//  Catinder
//
//  Created by Aleksey on 06/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileDataNavigationController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationBar.prefersLargeTitles = true
		
		let profileDataViewController = ProfileDataViewController()
		pushViewController(profileDataViewController, animated: true)
	}
}
