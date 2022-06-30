//
//  UIView+Extension.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/04.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
    func addGradient() {
            let gradient = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: 0, width: 375, height: 55)
            gradient.colors = [UIColor(hex: 0xffffff, alpha: 1).cgColor,UIColor(hex: 0xffffff, alpha: 0.9).cgColor, UIColor(hex: 0xffffff, alpha: 0).cgColor]
            gradient.locations = [0.8,  0.88, 1.0]
            self.layer.mask = gradient
    }
    func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            statusBarHeight = window?.safeAreaInsets.top ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
