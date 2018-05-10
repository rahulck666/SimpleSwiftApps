//
//  GTResponse.swift
//
//

import Foundation

struct GTResponse<Result>: CustomStringConvertible {
    // MARK: - Properties
    var headerReponse: [AnyHashable: Any]?
    var statusCode: Int?
    var result: Result?
    var request: GTRequestable?
    var jsonResponse: Any?

    // MARK: - init method
    init(response: HTTPURLResponse?, reponseObject: Result?, request: GTRequestable?, json: Any? = nil) {
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
