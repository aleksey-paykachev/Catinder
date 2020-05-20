//
//  UITableView + Extensions.swift
//  Catinder
//
//  Created by Aleksey on 20.05.2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

extension UITableView {

	/// Register a class for use in creating new table view cells.
	/// - Parameter cellType: Type of registered cell.
	///
	func registerCell(_ cellType: UITableViewCell.Type) {
		register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
	}
	
	/// Returns a reusable cell object of given cell type located by identifier.
	/// - Parameters:
	///   - cellType: Type of the cell.
	///   - indexPath: The reuse identifier for the specified cell.
	///
	func dequeueCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {

		guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {

			fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
		}

		return cell
	}
}
