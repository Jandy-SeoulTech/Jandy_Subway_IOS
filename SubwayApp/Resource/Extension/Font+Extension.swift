//
//  Font+.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/04.
//

import UIKit

extension UIFont {
    public enum RobotoType: String {
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
    }

    static func Roboto(_ type: RobotoType, size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-\(type.rawValue)", size: size)!
    }
}
