//
//  WCBaseModel
//  iLink
//
//  Created by RAHUL CK on 2/16/18.
//  Copyright © 2018 iLink. All rights reserved.
//
import ObjectMapper

class WCBaseModel: Mappable {
   @objc dynamic var identifier: String?

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        identifier <- map[WCNetworkConstants.CommonResponseKeys.identifier]
    }


   
}
