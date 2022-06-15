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
    
    open class var anzaBlack:UIColor? { UIColor(named: "anzaBlack") }
    open class var anzaBlue:UIColor? { UIColor(named: "anzaBlue") }
    open class var anzaDarkGray:UIColor? { UIColor(named: "anzaDarkGray") }
    open class var anzaGray1:UIColor? { UIColor(named: "anzaGray1") }
    open class var anzaGray2:UIColor? { UIColor(named: "anzaGray2") }
    open class var anzaGray4:UIColor? { UIColor(named: "anzaGray4") }
    open class var anzaLightBlue:UIColor? { UIColor(named: "anzaLightBlue") }
    open class var anzaLightBlue2:UIColor? { UIColor(named: "anzaLightBlue2") }
    open class var anzaLightGray:UIColor? { UIColor(named: "anzaLightGray") }
    open class var anzaRed:UIColor? { UIColor(named: "anzaRed") }
    open class var gray3:UIColor? { UIColor(named: "gray3") }
    open class var line1:UIColor? { UIColor(named: "line1") }
    open class var line2:UIColor? { UIColor(named: "line2") }
    open class var line3:UIColor? { UIColor(named: "line3") }
    open class var line4:UIColor? { UIColor(named: "line4") }
    open class var line5:UIColor? { UIColor(named: "line5") }
    open class var line6:UIColor? { UIColor(named: "line6") }
    open class var line7:UIColor? { UIColor(named: "line7") }
    open class var line8:UIColor? { UIColor(named: "line8") }
    open class var line9:UIColor? { UIColor(named: "line9") }
    open class var line10:UIColor? { UIColor(named: "line10") }
    open class var line11:UIColor? { UIColor(named: "line11") }
    open class var line12:UIColor? { UIColor(named: "line12") }
    open class var line13:UIColor? { UIColor(named: "line13") }
    open class var line14:UIColor? { UIColor(named: "line14") }
    open class var line15:UIColor? { UIColor(named: "line15") }
    open class var line16:UIColor? { UIColor(named: "line16") }
}
