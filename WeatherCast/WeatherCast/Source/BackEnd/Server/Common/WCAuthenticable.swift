//
//  Authenticable
//  iLink
//
//  Created by RAHUL CK on 2/16/18.
//  Copyright © 2018 iLink. All rights reserved.
//
import Foundation

/* If a API request requires authentication, then it must conform this protocol
 so that 'authorizationHeaders' can be appended to the headers or params */
protocol Authenticable {
    var authorizationHeaders: HeaderParams? { get }
}

/* 'Authenticable' extension which defines default values for the
 'authorizationHeaders' feild */
extension Authenticable {

    internal var authorizationHeaders: HeaderParams? {
        return nil
    }
}
