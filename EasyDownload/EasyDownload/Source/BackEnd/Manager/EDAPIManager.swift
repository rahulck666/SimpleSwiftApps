//
//  EDAPIManager.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 iLink. All rights reserved.
//


import Foundation
import Alamofire


typealias DownloadProgressCallBack =  (_ progress:Double) -> Void

class EDAPIManager {
    var sessionManager:SessionManager? = nil
    
    func requestDownload(endUrl:String,progress: @escaping DownloadProgressCallBack ,
                         completion: @escaping (_ response:EDDownloadResponse?, _ error:Error?) -> Void)  {
        let pathExtension = URL(string: endUrl)?.pathExtension ?? ""
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let fileURL = FileManager.pathForSavingDownloadedFiles(fileExtension: pathExtension)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        if  self.sessionManager == nil {
            let configuration = URLSessionConfiguration.background(withIdentifier: "com.easyDownload.app.background")
            self.sessionManager = Alamofire.SessionManager(configuration: configuration)
        }
        
        self.sessionManager?.download(endUrl, to: destination).downloadProgress { (downloadProgress) in
            progress(downloadProgress.fractionCompleted)
            }.responseData { (response) in
                switch response.result {
                case .success(let data):
                    if let fileUrl = response.destinationURL {
                        let responseObject = EDDownloadResponse(localUrl:fileUrl, data: data)
                        completion(responseObject, response.error)
                    }
                    else {
                        completion(nil, response.error)
                    }
                case .failure:
                    completion(nil, response.error)
                    
                }
                self.sessionManager?.session.invalidateAndCancel()
        }
    }
}

