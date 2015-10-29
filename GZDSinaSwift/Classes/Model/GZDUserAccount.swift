//
//  GZDUserAccount.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/30.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDUserAccount: NSObject ,NSCoding{
///用于调用access_token，接口获取授权后的access token。
    var access_token : String?
    ///access_token的生命周期，单位是秒数。
    var expires_in : NSTimeInterval = 0 {
        didSet{
          expires_date  =  NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    ///当前授权用户的UID
    var uid : String?
    
    var expires_date :NSDate?
    
    
    init(dict :[String : AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    //这个方法防治崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
   override var description: String {
    
    return "access_token = \(access_token)  expires_in = \(expires_in) uid = \(uid) expires_date = \(expires_date)"
    }
    
  static  let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/Account.plist"
    //保存自己的方法
    //哪一个对象调用就将哪一个对象保存到归档路径当中
    func saveAccount() {
        
        NSKeyedArchiver.archiveRootObject(self, toFile: GZDUserAccount.accountPath)
    }
    //解档的方法
    
    class func loadAccount() -> GZDUserAccount? {
        
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? GZDUserAccount
        
        return account
    }
    
    
    
    //MARK: - 归档和解档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
    }
    
    
    
}
