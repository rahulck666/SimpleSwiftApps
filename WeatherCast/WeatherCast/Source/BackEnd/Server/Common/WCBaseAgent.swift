//
//  WCBaseAgent.swift
//  iLink
//
//  Created by RAHUL CK on 2/10/18.
//  Copyright © 2018 iLink. All rights reserved.
//
import Foundation
import Alamofire

class WCBaseAgent {
    var manager: SessionManager?

    init(manager: SessionManager = SessionManager.default) {
        self.manager = manager
    }
}
