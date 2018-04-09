//
//  EdValidationHelper.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

let validExtensions = ["jpg","png","gif","mp4","mp3","mov","pdf"]

struct EdValidationHelper {
    
    static func validateDownloadUrl(urlString:String) -> Bool {
        
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                if validExtensions.contains(url.pathExtension.lowercased()) {
                    return true
                }
            }
        }
        return false
    }
}
