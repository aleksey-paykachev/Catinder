//
//  CatinderNavigationController.swift
//  Catinder
//
//  Created by Aleksey on 23/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderNavigationController: UINavigationController {
	
	let catinderNavigationBar = CatinderNavigationBar()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(catinderNavigationBar)
		navigationBar.isHidden = true
		delegate = catinderNavigationBar
		catinderNavigationBar.delegate = self		
	}
}


// MARK: - CatinderNavigationBarDelegate

extension CatinderNavigationController: CatinderNavigationBarDelegate {
	func backButtonDidPressed() {
		popViewController(animated: true)
	}
}
