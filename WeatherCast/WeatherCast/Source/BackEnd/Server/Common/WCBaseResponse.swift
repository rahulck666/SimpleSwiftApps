//
//  WCBaseResponse
//  iLink
//
//  Created by RAHUL CK on 2/16/18.
//  Copyright © 2018 iLink. All rights reserved.
//
import Foundation
import ObjectMapper

class WCBaseResponse: WCBaseModel {
    var statusCode: Int?


 

    // MARK: - Mappable protocol methods
    public override func mapping(map: Map) {
        super.mapping(map: map)
        statusCode <- map[WCNetworkConstants.LoginResponseKeys.statusCode]
    }
}
