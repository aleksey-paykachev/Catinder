//
//  MatchSplashScreenViewController.swift
//  Catinder
//
//  Created by Aleksey on 17/01/2020.
//  Copyright © 2020 Aleksey Paykachev. All rights reserved.
//

import UIKit

class MatchSplashScreenViewController: UIViewController {
	let blurView = UIVisualEffectView(effect: nil)

	let userProfileImageView = UIImageView(image: UIImage(named: "Cat_Marusia"))
	let matchProfileImageView = UIImageView(image: UIImage(named: "Cat_Bob_1"))
	
	// test button
	let playAnimationButton = UIButton(type: .custom)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		
		// test button
		playAnimationButton.setTitle("Play animation", for: .normal)
		view.addSubview(playAnimationButton)
		playAnimationButton.constrainToSuperview(anchors: [.bottom, .centerX], paddings: .bottom(20))
		playAnimationButton.addTarget(nil, action: #selector(playAnimation), for: .touchUpInside)
	}
	
	private func setup() {
		view.backgroundColor = .lightGray
		
		// blur
		view.insertSubview(blurView, at: 0)
		blurView.constrainToSuperview(respectSafeArea: false)
		
		// profiles
		let profileImageSize = view.frame.width * 0.33

		// user profile
		userProfileImageView.contentMode = .scaleAspectFill
		
		#warning("Refactor into separate function")
		userProfileImageView.constrainWidth(to: profileImageSize)
		userProfileImageView.constrainHeight(to: profileImageSize)

		#warning("Refactor into separate function")
		userProfileImageView.layer.cornerRadius = profileImageSize / 2
		userProfileImageView.layer.masksToBounds = true
		
		#warning("Refactor into separate function")
		userProfileImageView.layer.borderColor = UIColor.white.cgColor
		userProfileImageView.layer.borderWidth = 2
		
		// match profile
		matchProfileImageView.contentMode = .scaleAspectFill
		
		matchProfileImageView.constrainWidth(to: profileImageSize)
		matchProfileImageView.constrainHeight(to: profileImageSize)
		
		matchProfileImageView.layer.cornerRadius = profileImageSize / 2
		matchProfileImageView.layer.masksToBounds = true
		
		matchProfileImageView.layer.borderColor = UIColor.white.cgColor
		matchProfileImageView.layer.borderWidth = 2
		
		// match title
		let matchTitleLabel = UILabel()
		matchTitleLabel.text = "Совпадение!"
		matchTitleLabel.textColor = .white
		matchTitleLabel.font = .systemFont(ofSize: 36, weight: .medium)
		matchTitleLabel.textAlignment = .center
		
		// match description
		let matchDescriptionLabel = UILabel()
		matchDescriptionLabel.text = "Вы, и %secondUser% понравились друг другу."
		matchDescriptionLabel.textColor = .white
		matchDescriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
		matchDescriptionLabel.numberOfLines = 0
		
		// profiles stack
		let profilesStack = UIStackView(arrangedSubviews: [userProfileImageView, matchProfileImageView])
		profilesStack.axis = .horizontal
		profilesStack.spacing = 40
		
		// main stack
		let mainStack = UIStackView(arrangedSubviews: [matchTitleLabel, matchDescriptionLabel, profilesStack])
		mainStack.axis = .vertical
		mainStack.spacing = 10
		mainStack.setCustomSpacing(40, after: matchDescriptionLabel)
		
		view.addSubview(mainStack)
		mainStack.constrainToSuperview(anchors: [.centerX, .centerY])
	}
	
	private func prepareForAnimation() {
		blurView.effect = UIBlurEffect(style: .light)
		
		let offscreenX = UIScreen.main.bounds.width
		userProfileImageView.transform = CGAffineTransform(translationX: offscreenX, y: 0)
		matchProfileImageView.transform = CGAffineTransform(translationX: -offscreenX, y: 0)
	}
	
	@objc private func playAnimation() {
		prepareForAnimation()
		
		UIView.animateKeyframes(withDuration: 5, delay: 0, options: [], animations: {
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
				// blur
				self.blurView.effect = UIBlurEffect(style: .dark)
			}
			UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {
				// profiles
				self.userProfileImageView.transform = .identity
				self.matchProfileImageView.transform = .identity
			}
		}) { _ in
			print("Done")
		}
	}
}
