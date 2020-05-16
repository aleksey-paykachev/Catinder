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
	
	
	// MARK: - Notification message

	func showNotification(_ message: String, hideAfter intervalBeforeHide: TimeInterval = 4) {
		// properties
		let topConstraintHidden: CGFloat = -100
		var topConstraintShown: CGFloat = 10
		let widthConstraint: CGFloat = 300
		let animationDuration: TimeInterval = 0.3

		// tweak top size if current VC isn't in navigation stack
		if let navigationBar = navigationController?.navigationBar, navigationBar.isHidden {
			topConstraintShown += navigationBar.bounds.height
		}
		
		let notificationMessageView = NotificationMessageView(message: message)
		view.addSubview(notificationMessageView)

		// constraints
		notificationMessageView.translatesAutoresizingMaskIntoConstraints = false

		let notificationMessageViewTopConstraint = notificationMessageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintHidden)

		NSLayoutConstraint.activate([
			notificationMessageView.widthAnchor.constraint(equalToConstant: widthConstraint),
			notificationMessageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			notificationMessageViewTopConstraint
		])
		
		// show-wait-hide animation:
		// prepare
		notificationMessageView.alpha = 0
		view.layoutIfNeeded()
		
		// show
		UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
			notificationMessageViewTopConstraint.constant = topConstraintShown
			notificationMessageView.alpha = 1
			self.view.layoutIfNeeded()
		}, completion: { _ in
			
			// hide
			UIView.animate(withDuration: animationDuration, delay: intervalBeforeHide, options: .curveEaseIn, animations: {
				notificationMessageViewTopConstraint.constant = topConstraintHidden
				notificationMessageView.alpha = 0
				self.view.layoutIfNeeded()
			}, completion: { _ in
				
				// remove
				notificationMessageView.removeFromSuperview()
			})
		})
	}
}
