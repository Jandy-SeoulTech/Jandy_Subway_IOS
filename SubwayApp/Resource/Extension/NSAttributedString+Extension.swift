//
//  NSAttributedString+Extension.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/26.
//

import Foundation
import UIKit


extension NSAttributedString {
    static func anza_t1(text: String, color: UIColor?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 25
        let attrString = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.NotoSans(.semiBold, size: 24) as Any,
                         .paragraphStyle: paragraphStyle,
                         .foregroundColor: color as Any])
        return attrString
    }
    static func anza_b4_2(text: String, color: UIColor?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.NotoSans(.regular, size: 16) as Any,
                         .paragraphStyle: paragraphStyle,
                         .foregroundColor: color as Any])
        return attrString
    }
    static func anza_b2(text: String, color: UIColor?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.NotoSans(.regular, size: 14) as Any,
                         .paragraphStyle: paragraphStyle,
                         .foregroundColor: color as Any])
        return attrString
    }
    static func anza_b3(text: String, color: UIColor?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.NotoSans(.semiBold, size: 16) as Any,
                         .paragraphStyle: paragraphStyle,
                         .foregroundColor: color as Any])
        return attrString
    }
    static func anza_b5(text: String, color: UIColor?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.NotoSans(.medium, size: 10) as Any,
                         .paragraphStyle: paragraphStyle,
                         .foregroundColor: color as Any])
        return attrString
    }
    static func anza_b7(text: String, color: UIColor?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.NotoSans(.regular, size: 12) as Any,
                         .paragraphStyle: paragraphStyle,
                         .foregroundColor: color as Any])
        return attrString
    }
}
