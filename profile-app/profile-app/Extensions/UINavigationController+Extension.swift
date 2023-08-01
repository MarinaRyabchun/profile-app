//
//  Extension+ProfileViewController.swift
//  profile-app
//
//  Created by Марина Рябчун on 01.08.2023.
//

import UIKit

extension UINavigationController {
    override open func viewWillLayoutSubviews() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.Colors.backgroundColor
        appearance.shadowColor = nil
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
