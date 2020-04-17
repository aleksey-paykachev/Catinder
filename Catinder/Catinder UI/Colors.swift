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

	static let navigationContent = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9034442896, green: 0.3805156774, blue: 0.09398302256, alpha: 1) : #colorLiteral(red: 0.9372549057, green: 0.4767975687, blue: 0.2674589695, alpha: 1)
	})

	static let navigationBackground = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.06646573604, green: 0.06646573604, blue: 0.06646573604, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	})

}
