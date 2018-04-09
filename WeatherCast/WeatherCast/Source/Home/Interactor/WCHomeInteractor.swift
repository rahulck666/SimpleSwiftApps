//
//  WCHomeInteractor.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit
protocol WCHomeInteractorOutput:class {
    func didFinishFetchingWeatherData(success:Bool,response:WCWeather?,error:Error?)
    
}
protocol WCHomeInteractorInput:class {
    
    func fetchWeatherData(cityName:String)
}
class WCHomeInteractor: WCHomeInteractorInput {
    
    weak var output:WCHomeInteractorOutput?
    var managers: NSMutableArray = []
    
    init(interactorOutput:WCHomeInteractorOutput) {
        output = interactorOutput
    }
    
    /**
     Doing the initial setup for the controller
     parameter cityName : city name
     */
    func fetchWeatherData(cityName:String) {
        let manager = WCAPIManager()
        managers.add(manager)
        let apiKey = WCCredentials.apiKey
        manager.executeRequest(request:WCHomeRequest.fetchWeatherData(apiId: apiKey, city:cityName) , type: WCWeather.self, cachePolicy: .network) { (response, error) in
            if  error == nil && response != nil {
                self.output?.didFinishFetchingWeatherData(success: true, response: response?.result, error: nil)
            }
            else {
                self.output?.didFinishFetchingWeatherData(success: false, response: response?.result, error: error)
            }
        }
    }    
}
