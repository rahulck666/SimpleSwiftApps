//
//  WCAnimationHelper.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

class WCAnimationHelper: NSObject {
    
    static func shakeAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0,NSNumber(value: 1/6.0),NSNumber(value: 3/6.0),NSNumber(value: 5/6.0),1]
        animation.duration = 0.4
        animation.isAdditive = true
        return animation
    }
    static func movingAnimation() -> UIMotionEffectGroup {
      
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -50
        horizontalMotionEffect.maximumRelativeValue = 50
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -50
        verticalMotionEffect.maximumRelativeValue = 50
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        return motionEffectGroup
    }
    
    

    
    
   
}
