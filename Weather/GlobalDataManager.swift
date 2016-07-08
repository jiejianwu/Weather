//
//  GlobalDataManager.swift
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

import Foundation

@objc class GlobalDataManager: NSObject {
    
    static private var _shareInstance: GlobalDataManager?
    
    var yyWeatherKey: String {
        return "3iogp26qbvgj80b6"
    }
    
    class func shareInstance() -> GlobalDataManager {
        if _shareInstance == nil {
            _shareInstance = GlobalDataManager()
        }
        return _shareInstance!
    }
    
}
