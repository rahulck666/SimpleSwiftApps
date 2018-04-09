//
//  WCWeatherResponse.swift
//  WeatherCast
//
//  Created by RAHUL CK on 4/8/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit
import ObjectMapper

class WCWeather: WCBaseResponse {
    
    var city:String?
    var temperature:Double?

    public override func mapping(map: Map) {
        super.mapping(map: map)
        city <- map[WCNetworkConstants.WeatherResponseKeys.cityName]
        temperature <- map[WCNetworkConstants.WeatherResponseKeys.temperature]
        // MARK:- Converting to digree Celsious
        if let temperature = temperature {
            self.temperature = temperature - 272.15
        }
    }
    func isValid() -> Bool {
        return city != nil && temperature != nil
    }
    
}
