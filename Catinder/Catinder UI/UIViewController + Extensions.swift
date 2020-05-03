//
//  UIViewController + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 26/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIViewController {
	
	// MARK: - Catinder activity indicator
	
	private func addActivityIndicator() -> CatinderActivityIndicatorView {
		let activityIndicatorView = CatinderActivityIndicatorView()
		
		view.addSubview(activityIndicatorView)
		activityIndicatorView.constrainToSuperview(anchors: [.centerX, .centerY])
		
		return activityIndicatorView
	}
	
	func showActivityIndicator() {
		var activityIndicatorView = view.subviews.compactMap { $0 as? CatinderActivityIndicatorView }.last
		
		// if activity indicator doesn't exist, create one
		if activityIndicatorView == nil {
			activityIndicatorView = addActivityIndicator()
		}
		
		activityIndicatorView?.show()
	}
	
	func hideActivityIndicator() {
		view.subviews.compactMap { $0 as? CatinderActivityIndicatorView }.last?.hide()
	}
}
