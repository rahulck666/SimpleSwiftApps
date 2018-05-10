//
//  TestApiManager.swift
//  TestApi
//
//  Created by RAHUL CK on 5/9/18.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

struct GTAPIManager {
   
    static let shared = GTAPIManager()
    
    func executeRequest<A:BaseMappable>(request: GTRequestable,type:A.Type, completion: @escaping (GTResponse<A>?, Error?) -> Void)  {

        Alamofire.request(request).responseObject { (response: DataResponse<A>) in
                let response = GTResponse(response: response.response, reponseObject: response.result.value, request: request)
                completion(response,nil)
                
                }
        
    }


}
