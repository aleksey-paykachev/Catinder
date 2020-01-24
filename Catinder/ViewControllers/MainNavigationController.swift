//
//  MainNavigationController.swift
//  Catinder
//
//  Created by Aleksey on 23/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
	
	let catinderNavigationBar = CatinderNavigationBar()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(catinderNavigationBar)
		navigationBar.isHidden = true
		delegate = catinderNavigationBar
		catinderNavigationBar.delegate = self
		
		pushViewController(CardsViewerViewController(), animated: false)
	}
}


// MARK: - CatinderNavigationBarDelegate

extension MainNavigationController: CatinderNavigationBarDelegate {
	func backButtonDidPressed() {
		popViewController(animated: true)
	}
}
