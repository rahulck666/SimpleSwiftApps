//
//  GTEndPoint.swift
//  GameOfThrones
//
//  Created by RAHUL CK on 5/6/18.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import Alamofire

typealias HeaderParams = [String: String]
typealias APIParams = [String: Any]
typealias EncodingType = Alamofire.ParameterEncoding

/* RSEndpoint protocol defines a set a rules, on conforming to which, a type can
 be classfied as a API request */
protocol GTEndPoint {
    var baseURL: String? { get } // base url of the request
    var path: String? { get } // path component of the url
    var method: Alamofire.HTTPMethod? { get } // HTTP Method (e.g. GET, POST etc)
    var headers: HeaderParams? { get } // Header parameters
    var parameters: APIParams? { get } // Request Body/ Query Params
    var encoding: EncodingType? { get } // URL encoding for the request
    var predicate: NSPredicate? { get } // To fetch from Realm
}

extension GTEndPoint {
    
    internal var baseURL: String? { return "" }
    internal var path: String? { return nil }
    internal var method: Alamofire.HTTPMethod? { return .get }
    internal var headers: HeaderParams? { return [:] }
    internal var parameters: APIParams? { return nil }
    internal var encoding: EncodingType? { return Alamofire.JSONEncoding.default }
    internal var predicate: NSPredicate? { return nil }
}
