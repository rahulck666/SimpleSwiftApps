//
//  EDAnimationHelper.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

class EDAnimationHelper: NSObject {
    
    static func shakeAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0,NSNumber(value: 1/6.0),NSNumber(value: 3/6.0),NSNumber(value: 5/6.0),1]
        animation.duration = 0.4
        animation.isAdditive = true
        return animation
    }
}
