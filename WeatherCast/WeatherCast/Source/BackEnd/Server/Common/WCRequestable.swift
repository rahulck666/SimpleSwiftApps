//
//  WCRequestable.swift
//  iLink
//
//  Created by RAHUL CK on 2/10/18.
//  Copyright © 2018 iLink. All rights reserved.
//

import Foundation
import Alamofire

protocol WCRequestable: WCEndpoint, URLRequestConvertible {
}

extension WCRequestable {

    func asURLRequest() throws -> URLRequest {
        guard let urlString = baseURL else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        var resourceURL = try encodedUrlString.asURL()

        if let pathComponent = path {
            resourceURL = resourceURL.appendingPathComponent(pathComponent)
        }
        let urlRequest = try URLRequest(url: resourceURL, method: method!, headers: headers)
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }

    /**
     Header params to be passed for Get or Post request of type "application/x-www-form-urlencoded"

     - returns: HeaderParams
     */
    func headersForFormUrlEncodedRequest() -> HeaderParams {
        var parameters = HeaderParams()
        parameters[WCNetworkConstants.HeaderConstants.contentType] = WCNetworkConstants.HeaderConstants.contentTypeJson
        parameters[WCNetworkConstants.HeaderConstants.os] = WCNetworkConstants.HeaderConstants.iOS
            parameters[WCNetworkConstants.HeaderConstants.appVersion] = "1.0"
        
        return parameters
    }

    func headersForRequest() -> HeaderParams {
        var parameters = HeaderParams()
        parameters[WCNetworkConstants.HeaderConstants.os] = WCNetworkConstants.HeaderConstants.iOS
        parameters[WCNetworkConstants.HeaderConstants.contentType] = WCNetworkConstants.HeaderConstants.contentTypeJson
       
        return parameters
    }
}
