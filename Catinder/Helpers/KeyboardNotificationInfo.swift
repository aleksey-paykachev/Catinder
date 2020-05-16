//
//  KeyboardNotificationInfo.swift
//  Catinder
//
//  Created by Aleksey on 15.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

/// Contains values related to keyboard notification event.
struct KeyboardNotificationInfo {

	/// Type of keyboard notification.
	let type: NotificationType?

	/// Duration of keyboard appearance/disappearance animation.
	let animationDuration: TimeInterval
	
	/// Frame containing keyboard.
	let frame: CGRect
	
	/// Height of the keyboard.
	let height: CGFloat
	
	/// Width of the keyboard.
	let width: CGFloat
	
	/// Indicate if notification related to keyboard appearance.
	var isShowing: Bool {
		type == .willShow || type == .didShow
	}
	
	/// Indicate if notification related to keyboard disappearance.
	var isHiding: Bool {
		!isShowing
	}
	
	/// Creates and returns instance of keyboard notification info structure.
	/// - Parameter notification: Keyboard notification.
	///
	init?(of notification: Notification) {
		guard
			let userInfo = notification.userInfo,
			let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
			let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
			else {
				return nil
		}
		
		self.type = NotificationType(notificationName: notification.name)
		self.animationDuration = animationDuration
		self.frame = keyboardFrame
		self.height = keyboardFrame.size.height
		self.width = keyboardFrame.size.width
	}
	
	/// Represents type of keyboard notification.
	enum NotificationType {
		case willShow
		case didShow
		case willHide
		case didHide
		
		init?(notificationName: Notification.Name) {
			switch notificationName {
			case UIResponder.keyboardWillShowNotification:
				self = .willShow
			case UIResponder.keyboardDidShowNotification:
				self = .didShow
			case UIResponder.keyboardWillHideNotification:
				self = .willHide
			case UIResponder.keyboardDidHideNotification:
				self = .didHide
			default:
				return nil
			}
		}
	}
}
