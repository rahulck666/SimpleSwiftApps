//
//  RSAPIManager.swift
//  iLink
//
//  Created by RAHUL CK on 2/10/18.
//  Copyright © 2018 iLink. All rights reserved.
//


import Foundation
import ObjectMapper

class WCAPIManager {

    var agent: WCAgentProtocol?
    var cachePolicy: WCCachePolicy?

    func executeRequest<A: Mappable>(request: WCRequestable, type _: A.Type, cachePolicy: WCCachePolicy, completion: @escaping (WCResponse<A>?, Error?) -> Void)  {
        self.cachePolicy = cachePolicy
        agent = WCAgentFactory.agent(cachePolicy: cachePolicy)
        agent?.execute(request: request, completion: { responseObject, error in
            completion(responseObject, error)
        })
    }
    func save<A>(object: A?) {
        if let agent: WCNetworkAgent = agent as? WCNetworkAgent {
            agent.save(object: object)
        }
    }
    func cancel() {
        agent?.cancelRequest()
    }
    
}

class WCAgentFactory {
    static func agent(cachePolicy: WCCachePolicy) -> WCAgentProtocol? {
        switch cachePolicy {
        case .local:
            return WCNetworkAgent()
        case .network:
            return WCNetworkAgent()
        default:
            return nil
        }
    }
}
