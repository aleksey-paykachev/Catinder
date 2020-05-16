//
//  Colors.swift
//  Catinder
//
//  Created by Aleksey on 12.04.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UIColor {
	// MARK: - Common
	
	static let background = UIColor.systemBackground
	static let textFieldBorder = UIColor.tertiarySystemFill
	static let textFieldBackground = UIColor.tertiarySystemBackground
	static let error = UIColor.systemRed
	static let activityIndicator = #colorLiteral(red: 0.9015446749, green: 0.319128289, blue: 0, alpha: 1)

	
	// MARK: - Navigation
	
	static let navigationContent = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9034442896, green: 0.3805156774, blue: 0.09398302256, alpha: 1) : #colorLiteral(red: 0.9372549057, green: 0.4767975687, blue: 0.2674589695, alpha: 1)
	})

	static let navigationBackground = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.06646573604, green: 0.06646573604, blue: 0.06646573604, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	})

	
	// MARK: - Profile card
	
	static let profileCardTitle = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	})
	
	static let profileCardContent = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.94, green: 0.94, blue: 0.94, alpha: 1) : #colorLiteral(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
	})
	
	static let profileCardTint = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.92, green: 0.92, blue: 0.92, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	})
	
	
	// MARK: - Photo selector
	
	static let photoSelectorBorder = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) : #colorLiteral(red: 0.86, green: 0.86, blue: 0.86, alpha: 1)
	})
	
	static let photoSelectorPlaceholderImage = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1) : #colorLiteral(red: 0.76, green: 0.76, blue: 0.76, alpha: 1)
	})

	
	// MARK: - Conversation
	
	static let conversationBackground = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.03045731835, green: 0.044003285, blue: 0.05651818158, alpha: 1) : #colorLiteral(red: 0.8416953683, green: 0.8855920434, blue: 0.9355512857, alpha: 1)
	})
	
	static let conversationMessageText = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9716983438, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
	})
	
	static let conversationMessageBorder = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.1318882406, green: 0.1716943979, blue: 0.2215906978, alpha: 1) : #colorLiteral(red: 0.8145642877, green: 0.8508019447, blue: 0.871671021, alpha: 1)
	})
	
	static let conversationUserMessageBackground = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.2411876023, green: 0.3770276904, blue: 0.5472865105, alpha: 1) : #colorLiteral(red: 0.8876842856, green: 0.999817431, blue: 0.7837184072, alpha: 1)
	})
	
	static let conversationCollocutorMessageBackground = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.1356711686, green: 0.1795552075, blue: 0.229470253, alpha: 1) : #colorLiteral(red: 0.9999037385, green: 1, blue: 0.9957979321, alpha: 1)
	})
	
	
	// MARK: - Other

	static let lastMessagesProfileBorder = UIColor(dynamicProvider: { traitCollection in
		traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.8639001971, green: 0.5287541003, blue: 0.345114692, alpha: 1) : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
	})
}
