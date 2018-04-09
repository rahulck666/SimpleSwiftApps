//
//  WCNetworkConstants.swift
//  iLink
//
//  Created by RAHUL CK on 2/10/18.
//  Copyright © 2018 iLink. All rights reserved.
//


import Foundation

// MARK: - Network Constants
struct WCNetworkConstants {
    static let brandName = "iOS"
    
    // MARK: - API Endpoints
    struct APIEndpoints {
        static let productionUrl = "http://api.openweathermap.org/data/2.5/weather"
        static let stagingUrl = "http://api.openweathermap.org/data/2.5/weather"
        static let baseurl = productionUrl
        static let config = baseurl + "/" + "config.json"
        static let kLoginUser = baseurl + "auth/login"
        static let kfetchHomeData = baseurl + "job/myJob"
        static let kChangePassword = baseurl + "users/changePassword"
        static let kGetAllNotes = baseurl + "note/all/"
        static let kSaveNote = baseurl + "note/add"
        static let kUpdateJobStatus = baseurl + "job/changeStatus/"
        static let kGetAllRfq = baseurl + "rfq/all"
        static let kImageUpload =  "http://18.221.22.232:8000/api/upload"
        static let kAddRfq =  baseurl + "rfqRequest/add"

    }
    

    
    struct HeaderConstants {
        static let contentType = "Content-Type"
        static let contentTypeJson = "application/json"
        static let contentTypeText = "text/html"
        static let accept = "Accept"

        static let contentTypeUrlEncoded = "application/x-www-form-urlencoded"
        static let os = "OS"
        static let iOS = "iOS"
        static let mobile = "Mobile"
        static let tablet = "Tablet"
        static let screenResolution = "ScreenResolution"
        static let deviceType = "DeviceType"
        static let appVersion = "AppVersion"
        static let authorization = "Authorization"
        static let screenDensity = "ScreenDensity"
      

    }
    struct UserResponseKeys {
        static let id = "_id"
        static let firstName = "firstName"
        static let middleName = "middleName"
        static let lastName = "lastName"
        static let email = "email"
        static let userType = "userType"
        static let dateOfBirth = "birthDate"
        static let company = "company"


    }
    struct LoginResponseKeys {
        static let statusCode = "statusCode"
        static let authToken = "data.authToken"
        static let user = "data.user"

    }
    struct NoteResponseKeys {
        static let note = "note"
        static let usernote = "data.note"
        static let job = "job"


    }
    struct RfqResponseKeys {
        static let name = "name"
        static let proces = "data.process"
        static let design = "data.design"
        static let addOn = "data.addOn"
        static let addOnId = "addOnId"
        static let processId = "processId"
        static let designId = "designId"
        static let remarks = "remarks"
    }

    struct CommonResponseKeys {
        static let identifier = "id"
        static let assets = "assets"
        static let id = "_id"
        static let data = "data"
        static let imagePath = "imagePath"
        static let image = "image"


    }
 
    struct WeatherRequestKeys {
        static let city = "q"
        static let apiKey = "appid"
        static let currentPassword = "currentPassword"
        static let newPassword = "newPassword"
        
    }
    struct WeatherResponseKeys {
        static let cityName = "name"
        static let temperature = "main.temp"
        
    }
    struct LoginRequestKeys {
        static let userName = "username"
        static let password = "password"
        static let currentPassword = "currentPassword"
        static let newPassword = "newPassword"
        
    }
    struct JobRequestKeys {
        static let comment = "comment"
        static let status = "status"
        static let currentPassword = "currentPassword"
        static let newPassword = "newPassword"
        
    }
    struct NoteRequestKeys {
        static let note = "note"
        static let jobId = "jobId"
    }
    
   
    struct GetJobsresponseKeys {
        static let id = "_id"
        static let company = "company"
        static let name = "name"
        static let createdDate = "createdDate"
        static let updatedDate = "updatedDate"
        static let user = "user"
        static let status = "status"
        static let created_at = "created_at"
        static let updated_at = "updated_at"
        static let primaryContact = "primaryContact"
        static let orderNumber = "orderNumber"
        static let quantity = "quantity"
        static let price = "price"
        static let materialType = "materialType"
        static let invoiceNumber = "invoiceNumber"
        static let startDate = "startDate"
        static let endDate = "endDate"
        static let shipDate = "shipDate"
        static let jobNumber = "jobNumber"
        static let jobs = "data.jobs"


    }
    struct JobStatusString {
          static let orderReceived = "Order Received"
          static let materialReceived = "Material Received"
          static let firstInspection = "First Inspection"
          static let workInProgress = "Work In Progress"
          static let qualityAssurance = "Quality Assurance"
          static let shipped = "Shipped"
          static let arrived = "Arrived"
    }
    struct JobProperties {
        static let pointOfContact = "Point Of Contact"
        static let status = "Status"
        static let outSideRequests = "Outside Requests"
        static let orderTotal = "Order Total"
        static let quantity = "Quantity"
    }
   

}


// MARK: - Web service Environment

/* This enum specifies the web service envirnoment
 - production : specifies the production environment
 - staging    : specifies the staging environment */
enum WCWebServiceEnvironment {
    case production
    case staging
}

// MARK: - App Cache Policy

/* Specifies the cache policies used in the app
 - network : The data is directly fetched from the network and cache is updated
 - local   : The data is fetched from the cache (in our case 'Realm')
 - both    : The data is served from cache if not expired, otherwise from network */
enum WCCachePolicy: Int {
    case network
    case local
    case both
}

// MARK: - Network result enum

/* This enum represents the result of a network operation
 - success(value) : Represents success, 'value' represents result of operation
 - failure(error) : Represents failure case, with error */
enum Result<Value> {
    case success(value: Value)
    case failure(error: Error)
}
