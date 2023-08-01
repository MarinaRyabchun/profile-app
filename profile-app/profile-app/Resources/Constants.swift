//
//  Constants.swift
//  profile-app
//
//  Created by Марина Рябчун on 01.08.2023.
//

import UIKit

enum Constants{
    enum Colors{
        static var basicColor: UIColor? {
            UIColor(named: "basic")
        }
        static var descriptionColor: UIColor? {
            UIColor(named: "description")
        }
        static var backgroundColor: UIColor? {
            UIColor(named: "background")
        }
    }
    enum Fonts{
        static var header: UIFont? {
            UIFont(name: "Graphik-Bold", size: 24)
        }
        static var title: UIFont? {
            UIFont(name: "Graphik-Bold", size: 16)
        }
        static var subTitle: UIFont? {
            UIFont(name: "Graphik-Medium", size: 16)
        }
        static var text: UIFont? {
            UIFont(name: "Graphik-Regular", size: 14)
        }
    }
    enum Image {
        static let photoProfile = "photoProfile"
        static let iconPencil = "iconPencil"
        static let iconLocation = "iconLocation"
        static let iconСheckMark = "iconСheckMark"
    }
}
