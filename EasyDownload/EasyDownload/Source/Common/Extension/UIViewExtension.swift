

//
//  UIColorExtension.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/6/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

extension UIView {
    // This function is used to install shadow at the borders
    func installShadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width:0 , height:5)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.masksToBounds = false
    }

    // This function is used to display a view with gradient colors in the background
    func gradientOfView(withColours: UIColor...) {
        var cgColours = [CGColor]()
        for colour in withColours {
            cgColours.append(colour.cgColor)
        }
        let grad = CAGradientLayer()
        grad.frame = bounds
        grad.colors = cgColours
        layer.insertSublayer(grad, at: 0)
    }
}

