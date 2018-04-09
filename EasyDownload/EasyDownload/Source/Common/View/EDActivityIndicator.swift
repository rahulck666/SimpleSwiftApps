
//  EDActivityIndicator
//  iLink
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

class EDActivityIndicator: UIActivityIndicatorView {

    func showActivityIndicator(view: UIView) {
        showActivityIndicator(view: view, color: UIColor.darkPurple(), style: UIActivityIndicatorViewStyle.whiteLarge, enableUserInteraction: false)
    }

    func showActivityIndicator(view: UIView, enableUserInteraction: Bool) {
        showActivityIndicator(view: view, color: UIColor.darkPurple(), style: UIActivityIndicatorViewStyle.whiteLarge, enableUserInteraction: enableUserInteraction)
    }

    func showActivityIndicator(view: UIView, color: UIColor, style: UIActivityIndicatorViewStyle, enableUserInteraction: Bool) {

        //        self = UIActivityIndicatorView()
        frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        center = view.center
        hidesWhenStopped = true
        activityIndicatorViewStyle =
            style
        view.addSubview(self)
        view.bringSubview(toFront: self)
        translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)

        let verticalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        self.color = color
        startAnimating()
        view.isUserInteractionEnabled = enableUserInteraction
    }

    func removeActivityIndicator() {
        superview?.isUserInteractionEnabled = true
        stopAnimating()
        removeFromSuperview()
    }
}
