//
//  UITableViewController.swift
//  Catinder
//
//  Created by Aleksey on 24/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UITableViewController {
	
	open override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// if this TableViewController are using CatinderNavigationBar
		if let navigationBar = (navigationController as? MainNavigationController)?.catinderNavigationBar {
			
			// don't use safe area insets
			tableView.contentInsetAdjustmentBehavior = .never

			// and take custom navigation bar insets into account
			tableView.contentInset.top = navigationBar.height + navigationBar.bottomInset
		}
	}
}

