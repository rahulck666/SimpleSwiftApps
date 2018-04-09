//
//  UIColorExtension.swift
//  iLink
//
//  Created by RAHUL CK on 2/10/18.
//  Copyright © 2018 iLink. All rights reserved.
//
import UIKit

extension UIColor {



    /// Primary Blue
    class var primaryBlue: UIColor {
        return UIColor(hexString: "#193662")
        
    }
    /// Secondary Blue
    class var secondaryBlue: UIColor {
        return UIColor(hexString: "#2F4C78")
    }
  
    /// Secondary Green
    class var progressBarGreen: UIColor {
        return UIColor(red: 63.0 / 255.0, green: 179.0 / 255.0, blue: 80.0 / 255.0, alpha: 1)
    }
    /// Secondary Green
    class var primaryGreen: UIColor {
        return UIColor(red: 198.0 / 255.0, green: 196.0 / 255.0, blue: 120.0 / 255.0, alpha: 1)
    }
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        var a  = UInt32(alpha), r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))
    }

    class func darkPurple() -> UIColor {
        return UIColor(red: 64.0 / 255.0, green: 31.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0)
    }



  

   
}
