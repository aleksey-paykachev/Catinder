//
//  ProfileEditorNavigationController.swift
//  Catinder
//
//  Created by Aleksey on 06/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class ProfileEditorNavigationController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationBar.prefersLargeTitles = true
		
		let profileEditorViewController = ProfileEditorViewController()
		pushViewController(profileEditorViewController, animated: true)
	}
}
