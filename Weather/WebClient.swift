//
//  WebClient.swift
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//


class WebClient: AFHTTPSessionManager {

    static let baseUrl = "http://http://api.yytianqi.com/"
    static private var _shareInstance: WebClient?
    
    class func shareInstance() -> WebClient {
        if _shareInstance == nil {
            _shareInstance = WebClient(baseURL: NSURL(string: baseUrl))
        }
        return _shareInstance!
    }
    
    class func get(url: String, parameters: AnyObject?, success: ((NSURLSessionDataTask, AnyObject?) -> Void)?, failure: ((NSURLSessionDataTask?, NSError) -> Void)?) {
        shareInstance().GET(url, parameters: parameters, progress: nil, success: success, failure: failure)
    }
    
    class func post(url: String, parameters: AnyObject?, success: ((NSURLSessionDataTask, AnyObject?) -> Void)?, failure: ((NSURLSessionDataTask?, NSError) -> Void)?) {
        shareInstance().POST(url, parameters: parameters, progress: nil, success: success, failure: failure)
    }
    
}