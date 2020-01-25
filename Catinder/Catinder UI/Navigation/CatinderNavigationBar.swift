//
//  CatinderNavigationBar.swift
//  Catinder
//
//  Created by Aleksey on 23/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

protocol CatinderNavigationBarDelegate: class {
	func backButtonDidPressed()
}

class CatinderNavigationBar: UIView {
	
	// MARK: - Properties
	
	weak var delegate: CatinderNavigationBarDelegate?
	
	private(set) var height: CGFloat = 100
	let bottomInset: CGFloat = 30
	
	private var topConstraint: NSLayoutConstraint?
	private let titleLabel = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .medium))
	
	
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Setup
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		guard let superview = superview else { return }
		
		topConstraint = topAnchor.constraint(equalTo: superview.topAnchor)
		topConstraint?.isActive = true
		
		constrainToSuperview(anchors: [.leading, .trailing], respectSafeArea: false)
		constrainHeight(to: height)
	}
	
	private func setupView() {
		// appearance
		backgroundColor = .white
		layer.setShadow(size: 6, offsetY: 2, alpha: 0.2)
		
		// content area
		let contentArea = UIView()
		addSubview(contentArea)
		contentArea.constrainToSuperview(paddings: .horizontal(12), respectSafeArea: true)
		
		// back button
		let backButton = UIButton(type: .system)
		#warning("Add real back buton image.")
		backButton.backgroundColor = .red
		backButton.addTarget(self, action: #selector(backButtonDidPressed), for: .touchUpInside)
		contentArea.addSubview(backButton)
		backButton.constrainToSuperview(anchors: [.leading, .centerY])
		
		// title
		contentArea.addSubview(titleLabel)
		titleLabel.constrainToSuperview(anchors: [.centerX, .centerY])
	}
	
	
	// MARK: - Actions
	
	@objc private func backButtonDidPressed() {
		delegate?.backButtonDidPressed()
	}
	
	private func setToolbarVisible(visible: Bool, animated: Bool = true) {
		if !animated {
			topConstraint?.constant = visible ? 0 : -height
		} else {
			superview?.layoutIfNeeded()
			topConstraint?.constant = visible ? 0 : -height
			
			UIView.animate(withDuration: 0.25) {
				self.superview?.layoutIfNeeded()
			}
		}
	}
	
	private func setTitle(title: String?, animated: Bool) {
		titleLabel.text = title
		
		if let title = title, title.isNotEmpty {
			setToolbarVisible(visible: true, animated: animated)
		} else {
			setToolbarVisible(visible: false, animated: animated)
		}
	}
}


// MARK: - UINavigationControllerDelegate

extension CatinderNavigationBar: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

		setTitle(title: viewController.title, animated: animated)
	}
}
