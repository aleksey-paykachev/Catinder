//
//  UIViewController + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 26/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIViewController {
	
	// MARK: - Loading indicator
	
	private func addLoadingIndicator() -> UIActivityIndicatorView {
		let activityIndicatorView = UIActivityIndicatorView(style: .large)
		activityIndicatorView.color = .gray
		
		view.addSubview(activityIndicatorView)
		activityIndicatorView.constrainToSuperview(anchors: [.centerX, .centerY])
		
		return activityIndicatorView
	}
	
	func showLoadingIndicator() {
		var activityIndicatorView = view.subviews.compactMap { $0 as? UIActivityIndicatorView }.last
		
		// if loading indicator doesn't exist, create one
		if activityIndicatorView == nil {
			activityIndicatorView = addLoadingIndicator()
		}
		
		activityIndicatorView?.startAnimating()
	}
	
	func hideLoadingIndicator() {
		view.subviews.compactMap { $0 as? UIActivityIndicatorView }.last?.stopAnimating()
	}
}
