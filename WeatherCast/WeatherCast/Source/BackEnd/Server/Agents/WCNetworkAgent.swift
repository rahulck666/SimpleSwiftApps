//
//  WCNetworkAgent
//  iLink
//
//  Created by RAHUL CK on 2/16/18.
//  Copyright © 2018 iLink. All rights reserved.
//
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
typealias JSON = [String: Any]

class WCNetworkAgent: WCBaseAgent, WCAgentProtocol {
    var request: DataRequest?

    internal func cancelRequest() {
        request?.cancel()
    }

    internal func execute<A: Mappable>(request: WCRequestable, completion: @escaping (WCResponse<A>?, Error?) -> Void)  {
        
        self.request = manager?.request(request).responseObject(completionHandler: { (dataResponse: DataResponse<A>) in

            switch dataResponse.result {
            case let .success(value):
                var jsonResponse: Any?
                if let jsonData = dataResponse.data {
                    do {
                        jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)

                    } catch {
                    }
                }
                let dataResponse = WCResponse(response: dataResponse.response, reponseObject: value, request: request, json: jsonResponse)
                completion(dataResponse, nil)
            case let .failure(error):
                completion(nil, error)
            }
        })
    }
  
    func save<A>(object: A?) {
//        let realm = RSRealmDBManager.sharedInstance.realmRef()
//
//        try? realm.write {
//            if let object = object as? Object {
//                realm.add(object, update: true)
//            }
//        }
    }
}
