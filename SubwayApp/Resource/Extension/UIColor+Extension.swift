//
//  UIColor+.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/04.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}
extension UIColor {
    open class var anza_blue:UIColor? { UIColor(named: "anza_blue") }               // rgb 32 94 255
    open class var anza_black:UIColor? { UIColor(named: "anza_black") }             // rgb 36 36 36
    open class var anza_red:UIColor? { UIColor(named: "anza_red") }                 // rgb 237 62 68
    open class var anza_gray1:UIColor? { UIColor(named: "anza_gray1") }             // rgb 217 217 217
    open class var anza_gray2:UIColor? { UIColor(named: "anza_gray2") }             // rgb 158 158 158
    open class var anza_dark_gray:UIColor? { UIColor(named: "anza_dark_gray") }     // rgb 85 85 85
    open class var anza_light_gray:UIColor? { UIColor(named: "anza_light_gray") }   // rgb 223 223 223
    open class var anza_light_blue1:UIColor? { UIColor(named: "anza_light_blue1") } // rgb 111 151 255
    open class var anza_light_blue2:UIColor? { UIColor(named: "anza_light_blue2") } // rgb 215 226 255
}
