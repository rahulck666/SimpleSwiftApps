//
//  RSResponse.swift
//  iLink
//
//  Created by RAHUL CK on 2/10/18.
//  Copyright © 2018 iLink. All rights reserved.
//
import Foundation

struct WCResponse<Result>: CustomStringConvertible {
    // MARK: - Properties
    var headerReponse: [AnyHashable: Any]?
    var statusCode: Int?
    var result: Result?
    var request: WCRequestable?
    var jsonResponse: Any?

    // MARK: - init method
    init(response: HTTPURLResponse?, reponseObject: Result?, request: WCRequestable?, json: Any? = nil) {
        headerReponse = response?.allHeaderFields
        result = reponseObject
        statusCode = response?.statusCode
        self.request = request
        jsonResponse = json
    }
    
    var description: String {
        var description = ""
        if let method = request?.method {
            description += "Request method: \(method)\n"
        }
        if let params = request?.parameters {
            description += "Request parameters: \(params)\n"
        }
        if let baseUrl = request?.baseURL {
            description += "Request url: \(baseUrl)\n"
        }
        if let result = result {
            description += "Response: \(result)\n"
        }
        return description
    }
}
