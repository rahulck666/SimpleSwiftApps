
//  WCErrorCodeEnum
//  EasyDownload
//
//  Created by RAHUL CK on 4/6/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import Foundation

enum WCErrorCodeEnum: Int {
    case sessionTimedOut = -1001
    case networkUnavailable = -1111
    case locationServiceUnavailable = -5001
    case emailAlreadyRegistered = -5002
    case invalidUserIdOrPassword = 966
    case unknown = -1002
}

/// enum to hold all error codes used in the app
enum WCError {
    case sessionTimedOut
    case networkUnavailable
    case locationServiceUnavailable
    case emailAlreadyRegistered
    case invalidUserIdOrPassword
    case unknown
    case customMessage(message: String, code: Int?)
    case customError(error: Error)
}

extension WCError {
    public var code: WCErrorCodeEnum {
        switch self {
        case .sessionTimedOut:
            return WCErrorCodeEnum.sessionTimedOut
        case .networkUnavailable:
            return WCErrorCodeEnum.networkUnavailable
        case .locationServiceUnavailable:
            return WCErrorCodeEnum.locationServiceUnavailable
        case .emailAlreadyRegistered:
            return WCErrorCodeEnum.emailAlreadyRegistered
        case .invalidUserIdOrPassword:
            return WCErrorCodeEnum.invalidUserIdOrPassword
        case let .customMessage(_, code):
            if let errorCode = code {
                return WCErrorCodeEnum(rawValue: errorCode) ?? WCErrorCodeEnum.unknown
            }
            return WCErrorCodeEnum.unknown
        case let .customError(error):
                return WCErrorCodeEnum(rawValue: error._code) ?? WCErrorCodeEnum.unknown
        default:
            return WCErrorCodeEnum.unknown
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
