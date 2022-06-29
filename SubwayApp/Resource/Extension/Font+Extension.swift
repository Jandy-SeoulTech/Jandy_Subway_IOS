//
//  Font+.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/04.
//

import UIKit

extension UIFont {
    public enum FontType: String {
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    }

    static func Roboto(_ type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-\(type.rawValue)", size: size)!
    }
    static func NotoSans(_ type: FontType, size: CGFloat) -> UIFont {
        if type == .regular {
            return UIFont(name: "NotoSansKR-Regular", size: size)!
        } else if(type == .semiBold) {
            return UIFont(name: "NotoSans-SemiBold", size: size)!
        } else if(type == .medium) {
            return UIFont(name: "NotoSansKR-Medium", size: size)!
        }
        return Roboto(type, size: size)
    }
}
