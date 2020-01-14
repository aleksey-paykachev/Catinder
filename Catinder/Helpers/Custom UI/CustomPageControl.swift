//
//  CustomPageControl.swift
//  Catinder
//
//  Created by Aleksey on 03/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class CustomPageControl: UIView {
	var numberOfPages = 0 { didSet { setNumberOfPages() } }
	var currentPage = 0 { didSet { setCurrentPage() } }

	private var pageIndicators: [PageIndicatorView] = []
	
	private lazy var pageIndicatorsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 5
		
		addSubview(stackView)
		stackView.constrainToSuperview()
		
		return stackView
	}()
	
	private func setNumberOfPages() {
		// remove all existing page indicators
		pageIndicators = []
		pageIndicatorsStackView.removeAllArrangedSubviews()

		// and add new ones
		for _ in 0..<numberOfPages {
			let pageIndicator = PageIndicatorView()
			pageIndicators.append(pageIndicator)
			pageIndicatorsStackView.addArrangedSubview(pageIndicator)
		}

		// hide indicators if there is one or zero pages
		pageIndicatorsStackView.isHidden = numberOfPages <= 1
	}
	
	private func setCurrentPage() {
		guard (0..<numberOfPages).contains(currentPage) else { return }
		
		pageIndicators.forEach { $0.deselect() }
		pageIndicators[currentPage].select()
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 100, height: 5)
	}
	
	
	// MARK: - Single page indicator view
	
	private class PageIndicatorView: UIView {
		func select() {
			backgroundColor = UIColor(white: 1, alpha: 0.9)
		}
		
		func deselect() {
			backgroundColor = UIColor(white: 1, alpha: 0.4)
		}
	}
}

