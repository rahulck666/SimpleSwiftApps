
//  NSObjectExtension.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/6/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

extension NSObject {

    /// Returns class name string
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
