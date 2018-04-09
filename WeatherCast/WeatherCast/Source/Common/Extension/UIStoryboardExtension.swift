
//  UIStoryboardExtension.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/6/18.
//  Copyright © 2018 ILink. All rights reserved.
//


import UIKit

extension UIStoryboard {
    /// return main story board
    class func homeStoryboard() -> UIStoryboard {
        return UIStoryboard(name: WCStoryboardConstants.home, bundle: nil)
    }
}
