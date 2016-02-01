//
//  SBListenModel.swift
//  ABC360
//
//  Created by ChuckMAC on 16/1/25.
//  Copyright © 2016年 abc360.com. All rights reserved.
//

import UIKit

class SBListenInfoModel: NSObject {
    var name        : String!            // 名字
    var avatar      : String!            // 头像路径
    var content     : String!            // 内容
    var isLeft      : Bool!              // 位置
    var startTime   : Float!             // 音频播放路径
    
    init(info: [String: AnyObject]) {
        super.init()
        
        self.name       = toString(info, key: "name")
        self.avatar     = toString(info, key: "avatar")
        self.content    = toString(info, key: "text")
        self.isLeft     = toNumber(info, key: "isLeft")?.boolValue ?? false
        self.startTime  = toNumber(info, key: "start_time")?.floatValue ?? 0
    }
    
    func toString(dic:[String: AnyObject]?, key:String)-> String? {
        if let _dic = dic, value = _dic[key] as? String {
            return value
        }
        return nil
    }
    
    func toNumber(dic:[String: AnyObject]?, key:String)-> NSNumber? {
        if let _dic = dic {
            if let _value = _dic[key] as? NSNumber {
                return _value
            } else if let _value = _dic[key] as? String {
                let intValue = (_value as NSString).integerValue
                return NSNumber(integer: intValue)
            }
        }
        return nil
    }
}

class SBListenModel: NSObject {
    var URL     :String!                // 播放路径
    var infos   :[SBListenInfoModel]!   // 音频播放信息
    
    init(url: String, infos: [SBListenInfoModel]) {
        super.init()
        
        self.URL    = url
        self.infos  = infos
    }
}
