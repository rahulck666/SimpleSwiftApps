//
//  EDDownloadResponse.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

class EDDownloadResponse: EDBaseResponse {
    var localUrl:URL
    var data:Data?
    init(localUrl:URL,data:Data?) {
        self.localUrl = localUrl
        self.data = data
    }
}
