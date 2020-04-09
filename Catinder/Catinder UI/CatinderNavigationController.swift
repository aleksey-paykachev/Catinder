//
//  CatinderNavigationController.swift
//  Catinder
//
//  Created by Aleksey on 23/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CatinderNavigationController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupAppearance()
		setupNavigationBar()
	}
	
	private func setupAppearance() {
		let navigationBarAppearance = UINavigationBar.appearance()
		navigationBarAppearance.tintColor = .darkGray
		navigationBarAppearance.barTintColor = .white
		navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
	}
	
	private func setupNavigationBar() {
		// remove bottom line and add real shadow instead
		navigationBar.shadowImage = UIImage()
		navigationBar.layer.setShadow(size: 6, offsetY: 2, alpha: 0.2)
	}
}
