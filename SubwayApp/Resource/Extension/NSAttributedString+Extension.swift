//
//  NSAttributedString+Extension.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/26.
//

import Foundation
import UIKit


extension NSAttributedString {
    static func anza_t1(with text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 25
        let attrString = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.NotoSans(.semiBold, size: 24) as Any,
                         .paragraphStyle: paragraphStyle,
                         .foregroundColor: UIColor.anzaBlack as Any])
        return attrString
    }
}
