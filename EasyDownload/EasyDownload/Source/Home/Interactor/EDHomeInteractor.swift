//
//  EDHomeInteractor.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/7/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit
protocol EDHomeInteractorOutput:class {
    
    func didFinishDownloadingFile(success:Bool,response:EDDownloadResponse?,error:Error?)
    func didUpdateDownloadProgress(progress:Double)
    func didFinishFetchingAllDownloadedFiles(success:Bool,files:[URL]?)
    func didFinishDeleteFile(success:Bool,file:URL)
}
protocol EDHomeInteractorInput:class {
    func downloadFile(with url:String)
    func fetchAllDownloadedFiles()
    func deleteFile(file:URL)
    
}
class EDHomeInteractor: EDHomeInteractorInput {
    
    weak var output:EDHomeInteractorOutput?
    var managers: NSMutableArray = []
    init(interactorOutput:EDHomeInteractorOutput) {
        output = interactorOutput
    }
    
    /**
     Download a file to predefined location in document directory
     - parameter url: http url of the file to download
     */
    func downloadFile(with url:String) {
        let manager = EDAPIManager()
        managers.add(manager)
        manager.requestDownload(endUrl: url, progress: { (progress) in
            self.output?.didUpdateDownloadProgress(progress: progress)
        }) { (response, error) in
            if error == nil && response != nil {
                self.output?.didFinishDownloadingFile(success: true, response: response, error: nil)
            }
            else {
                self.output?.didFinishDownloadingFile(success: false, response: response, error: error)
            }
        }
    }
    /**
    Fetches all downloed files from disk
     */
    func fetchAllDownloadedFiles() {
        do {
            let downloadedFiles = try FileManager.default.contentsOfDirectory(at: FileManager.directoryForDownloadedFiles, includingPropertiesForKeys: nil)
            output?.didFinishFetchingAllDownloadedFiles(success: true, files: downloadedFiles)
        }
        catch {
            output?.didFinishFetchingAllDownloadedFiles(success: false, files: nil)
            
        }
        
    }
    /**
     Delete the file from the disk and free the storage space
     - parameter file: local url of the file to delete
     - returns:
     */
    func deleteFile(file:URL) {
        do {
            try FileManager.default.removeItem(at: file)
            self.output?.didFinishDeleteFile(success: true, file: file)
        }
        catch {
            self.output?.didFinishDeleteFile(success: false, file: file)
        }
    }
    
}
