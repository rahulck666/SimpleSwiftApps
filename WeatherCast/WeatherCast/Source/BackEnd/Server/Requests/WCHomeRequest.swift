//
//  WCHomeRequest.swift
//  iLink
//
//  Created by RAHUL CK on 2/27/18.
//  Copyright © 2018 iLink. All rights reserved.
//

import Foundation
import Alamofire
enum WCHomeRequest: WCRequestable, Authenticable {
    case fetchWeatherData(apiId:String,city:String)

    
    var baseURL: String? {
        switch self {
        case  .fetchWeatherData(_,_):
            return WCNetworkConstants.APIEndpoints.baseurl
     
        }
    }
    var path: String? {
        switch self {
        case  .fetchWeatherData(_,_):
            return nil
            
        }
    }
    
    var parameters: APIParams? {
    
        switch self {
        case let .fetchWeatherData(apiId:appId,city:city):
            var parameters = APIParams()
            parameters[WCNetworkConstants.WeatherRequestKeys.apiKey] = appId
            parameters[WCNetworkConstants.WeatherRequestKeys.city] = city
            return parameters
        }
    }
    
    var predicate: NSPredicate? {
        return nil
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
    
    var method: Alamofire.HTTPMethod? {
        switch self {
        case  .fetchWeatherData(_,_):
            return .get
            
        }
    }
    
    var headers: HeaderParams? {
        switch self {
        case  .fetchWeatherData(_,_):
            return nil
        }
    }
}
