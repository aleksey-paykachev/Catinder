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
		navigationBarAppearance.barTintColor = .navigationBackground
		navigationBarAppearance.tintColor = .navigationContent
		navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.navigationContent]
	}
	
	private func setupNavigationBar() {
		// remove bottom line and add real shadow instead
		navigationBar.shadowImage = UIImage()
		navigationBar.layer.setShadow(size: 4, offsetY: 2, alpha: 0.1)
	}
}
