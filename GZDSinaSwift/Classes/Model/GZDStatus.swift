//
//  GZDStatus.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/1.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDStatus: NSObject {
    
    /// 微博创建时间
    var created_at: String?
    
    /// 字符串型的微博ID
    var idstr: String?
    
    /// 微博信息内容
    var text: String?
    
    /// 微博来源
    var source: String?
    
    /// 微博的配图
    var pic_urls: [[String: AnyObject]]?
    
    /// 用户模型
    var user : GZDUser?
    
    init (dict : [String : AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    //防止应用程序崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    //kvc赋值每个属性的时候会调用
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "user" {
            //如果值是1个字典,如果字典里面有值
            
            if let dict = value as? [String : AnyObject] {
                
                //再让user 自己字典转模型
                
                user =  GZDUser(dict: dict)
                
                return
                
            }
        }
        
        
        return super.setValue(value, forKey: key)
    }
    
    
    
    
    //打印的方法
    
    override var description : String {
        
        let parameters = ["created_at","idstr","text","source","pic_urls"]
        
        return "\n\t:\(dictionaryWithValuesForKeys(parameters))"
    }
    
    //发送网络请求 并且字典转模型的工作由模型来关心
    
    class func loadStatus ( finished:(statuses:[GZDStatus]?,error:NSError?) -> ()) {
        
        //加载网络请求  返回微博数据
        GZDNetworkTools.sharedInstance.loadStauts { (result, error) -> (Void) in
            
            if error != nil{
                //如果有错误  那么就把错误返回给调用者
                finished(statuses: nil, error: error)
                return
            }
            //拿到微博数据之后 进行字典转模型
            if   let sourceArr = result?["statuses"] as? [[String:AnyObject]]{
                
                var finalArray = [GZDStatus]()
                
                for dict:[String:AnyObject] in sourceArr {
                    
                    finalArray.append(GZDStatus(dict: dict))
                }
                
                finished(statuses: finalArray, error: nil)
                
                return
            }
            finished (statuses: nil, error: error)
            
        }
    }
}











