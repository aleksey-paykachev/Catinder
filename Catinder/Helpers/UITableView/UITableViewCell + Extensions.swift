//
//  UITableViewCell + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 20.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UITableViewCell {
	
	/// String representation of the class name.
	static var className: String {
		String(describing: self)
	}
	
	/// Reuse identifier of the cell for table view.
	static var reuseIdentifier: String {
		className + "ReuseIdentifier"
	}
}
