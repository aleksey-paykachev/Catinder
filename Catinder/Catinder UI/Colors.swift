//
//  Colors.swift
//  Catinder
//
//  Created by Aleksey on 12.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIColor {
	static let background = UIColor.systemBackground
		
	// MARK: - Profile Card
	
	static let profileCardTitle = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	})
	
	static let profileCardContent = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.94, green: 0.94, blue: 0.94, alpha: 1) : #colorLiteral(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
	})
	
	static let profileCardTint = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.92, green: 0.92, blue: 0.92, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	})

	
	// MARK: - Navigation
	
	static let navigationContent = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9034442896, green: 0.3805156774, blue: 0.09398302256, alpha: 1) : #colorLiteral(red: 0.9372549057, green: 0.4767975687, blue: 0.2674589695, alpha: 1)
	})

	static let navigationBackground = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.06646573604, green: 0.06646573604, blue: 0.06646573604, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	})

	
	// MARK: - Other
	
	static let activityIndicator = #colorLiteral(red: 0.9015446749, green: 0.319128289, blue: 0, alpha: 1)

	static let lastMessagesProfileBorder = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.8639001971, green: 0.5287541003, blue: 0.345114692, alpha: 1) : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
	})
}
