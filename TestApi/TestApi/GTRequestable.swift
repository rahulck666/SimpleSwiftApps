//
//  GTRequestable.swift
//  GameOfThrones
//
//  Created by RAHUL CK on 5/6/18.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import Alamofire

protocol GTRequestable:URLRequestConvertible,GTEndPoint {
    
}
extension GTRequestable {
    
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
}
