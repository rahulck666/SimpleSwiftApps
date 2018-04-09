
//  DataExtension.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/6/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import Foundation

extension Data {
    func append(fileURL: URL) throws {

        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: fileURL, options: .atomicWrite)
        }
    }
}

extension FileManager {

    class var documentDirectoryURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    class var directoryForDownloadedFiles: URL {
        return createDirectory("Downloaded_Files")
    }
    static func pathForSavingDownloadedFiles(fileExtension:String) -> URL  {
        let uniqueNamePart = String.randomString(length: 5)
        let fileURL = directoryForDownloadedFiles.appendingPathComponent("\(EDLocalizationConstants.easyDownloadFileName + uniqueNamePart).\(fileExtension)")
      return fileURL
        
    }
    class func createDirectory(_ directoryName: String) -> URL {
        let pausedDiectory = FileManager.documentDirectoryURL!.appendingPathComponent(directoryName)
        if !FileManager.default.fileExists(atPath: pausedDiectory.relativePath) {
            do {
                try FileManager.default.createDirectory(atPath: pausedDiectory.relativePath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return pausedDiectory
    }
}
