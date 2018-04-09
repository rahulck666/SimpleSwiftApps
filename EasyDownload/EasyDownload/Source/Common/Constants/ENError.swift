
//  EDErrorCodeEnum
//  EasyDownload
//
//  Created by RAHUL CK on 4/6/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import Foundation

enum EDErrorCodeEnum: Int {
    case sessionTimedOut = -1001
    case networkUnavailable = -1111
    case locationServiceUnavailable = -5001
    case emailAlreadyRegistered = -5002
    case invalidUserIdOrPassword = 966
    case unknown = -1002
}

/// enum to hold all error codes used in the app
enum EDError {
    case sessionTimedOut
    case networkUnavailable
    case locationServiceUnavailable
    case emailAlreadyRegistered
    case invalidUserIdOrPassword
    case unknown
    case customMessage(message: String, code: Int?)
    case customError(error: Error)
}

extension EDError {
    public var code: EDErrorCodeEnum {
        switch self {
        case .sessionTimedOut:
            return EDErrorCodeEnum.sessionTimedOut
        case .networkUnavailable:
            return EDErrorCodeEnum.networkUnavailable
        case .locationServiceUnavailable:
            return EDErrorCodeEnum.locationServiceUnavailable
        case .emailAlreadyRegistered:
            return EDErrorCodeEnum.emailAlreadyRegistered
        case .invalidUserIdOrPassword:
            return EDErrorCodeEnum.invalidUserIdOrPassword
        case let .customMessage(_, code):
            if let errorCode = code {
                return EDErrorCodeEnum(rawValue: errorCode) ?? EDErrorCodeEnum.unknown
            }
            return EDErrorCodeEnum.unknown
        case let .customError(error):
                return EDErrorCodeEnum(rawValue: error._code) ?? EDErrorCodeEnum.unknown
        default:
            return EDErrorCodeEnum.unknown
        }
    }

    public var localizedDescription: String {
        switch self {
        case .sessionTimedOut:
            return ""
        case .networkUnavailable:
            return ""
        case .locationServiceUnavailable:
            return ""
        case let .customMessage(message, _):
            return message
        case let .customError(error):
            return error.localizedDescription
        default:
            return ""
        }
    }
}
