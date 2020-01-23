//
//  MainNavigationController.swift
//  Catinder
//
//  Created by Aleksey on 23/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationBar.isHidden = true
		pushViewController(CardsViewerViewController(), animated: false)
	}
}
