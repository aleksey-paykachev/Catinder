//
//  UICollectionViewCell + Extension.swift
//  Catinder
//
//  Created by Aleksey on 03.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
	
	/// String representation of the class name.
	static var className: String {
		String(describing: self)
	}
	
	/// Reuse identifier of the cell for collection view.
	static var reuseIdentifier: String {
		className + "ReuseIdentifier"
	}
}
