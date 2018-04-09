//
//  WCReachabilityManager.swift
//  iLink
//
//  Created by RAHUL CK on 2/10/18.
//  Copyright © 2018 iLink. All rights reserved.
//

import UIKit
import SystemConfiguration
import Alamofire

enum ConnectionNetworkType: String {
    case Wifi
    case Cellular
    case Other
}

protocol WCReachabilityManagerDelegate: class {
    // inform the controller that api call is successful
    func reachabilityStatusChangeHandler(reachability: Reachability)
}

class WCReachabilityManager {
    weak var delegate: WCReachabilityManagerDelegate?
    private var reachability: Reachability?
    private var _isReachability: Bool = false
    private var _reachabiltyNetworkType: String?

    var isReachability: Bool { return _isReachability }

    var reachabiltyNetworkType: String { return _reachabiltyNetworkType! }

    var isWifiReachable: Bool { return _reachabiltyNetworkType == ConnectionNetworkType.Wifi.rawValue }

    // Create a shared instance of RSReachabilityManager
    final class var sharedInstance: WCReachabilityManager {
        struct Static {
            static var instance: WCReachabilityManager?
        }
        if !(Static.instance != nil) {
            Static.instance = WCReachabilityManager()
        }
        return Static.instance!
    }

    // Reachability Methods
    func initRechabilityMonitor() {
        let reachability = Reachability()
        self.reachability = reachability
        NotificationCenter.default.addObserver(self, selector: #selector(WCReachabilityManager.reachabilityChanged(note:)), name: ReachabilityChangedNotification, object: reachability)

        notifyReachability(reachability: reachability!)

        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }

    private func notifyReachability(reachability: Reachability) {
        if reachability.isReachable {
            _isReachability = true

            // Determine Network Type
            if reachability.isReachableViaWiFi {
                _reachabiltyNetworkType = ConnectionNetworkType.Wifi.rawValue
            } else {
                _reachabiltyNetworkType = ConnectionNetworkType.Cellular.rawValue
            }
        } else {
            _isReachability = false
            _reachabiltyNetworkType = ConnectionNetworkType.Other.rawValue
        }
    }

    func isRechableViaWifi() -> Bool {
        return reachability?.isReachableViaWiFi ?? false
    }

    @objc func reachabilityChanged(note _: NSNotification) {
        guard let reachability = self.reachability else { return }
        DispatchQueue.main.async {
            self.notifyReachability(reachability: reachability)
            self.delegate?.reachabilityStatusChangeHandler(reachability: reachability)
        }
    }

    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
    }
}
