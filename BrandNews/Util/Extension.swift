//
//  UIColor.swift
//  BrandNews
//
//  Created by 박진수 on 08/05/2019.
//  Copyright © 2019 박진수. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    class var dark: UIColor {
        return UIColor(hex: 0x1c1f23)
    }
    
    class var veryDarkBrown7: UIColor {
        return UIColor(red: 4, green: 0, blue: 0, a: 0.07)
    }
    
    class var textWhite: UIColor {
        return UIColor(hex: 0xfefefe)
    }
    
    class var squash: UIColor {
        return UIColor(red: 248, green: 165, blue: 27)
    }
    
    class var velvet: UIColor {
        return UIColor(red: 129, green: 13, blue: 112)
    }
    
    class var grapefruit: UIColor {
        return UIColor(red: 254, green: 88, blue: 88)
    }
    
    class var sapphire: UIColor {
        return UIColor(red: 30, green: 51, blue: 175)
    }
    
    class var darkSkyBlue: UIColor {
        return UIColor(red: 35, green: 137, blue: 223)
    }
    
    class var vermillion: UIColor {
        return UIColor(red: 222, green: 14, blue: 14)
    }
    
    class var orange: UIColor {
        return UIColor(red: 245, green: 96, blue: 6)
    }
    
    class var warmGrey: UIColor {
        return UIColor(red: 155, green: 155, blue: 155)
    }
    
    class var turquoise: UIColor {
        return UIColor(red: 0, green: 172, blue: 172)
    }
    
    class var sapphireTwo: UIColor {
        return UIColor(red: 29, green: 37, blue: 167)
    }
    
}

extension CALayer {
    func setShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        }
    }
}

extension UIView {
    enum ViewBorder {
        case left
        case right
        case top
        case bottom
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addBorder(toSide side: ViewBorder, withColor color: UIColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
}

