//
//  WCAgentProtocol
//  iLink
//
//  Created by RAHUL CK on 2/16/18.
//  Copyright © 2018 iLink. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

protocol WCAgentProtocol {
    func execute<A: Mappable>(request: WCRequestable, completion: @escaping (WCResponse<A>?, Error?) -> Void) 
    func cancelRequest()
}
