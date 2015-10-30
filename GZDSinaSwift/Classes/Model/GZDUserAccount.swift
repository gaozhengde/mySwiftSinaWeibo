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
    
    ///记录账户授权失效时间
    var expires_date :NSDate?
    ///友好显示名称
    var name : String?
    ///用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    
    
    init(dict :[String : AnyObject]) {
        
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    //这个方法防治崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

    ///重写description 方法 打印
    override var description: String {
        return "access_token:\(access_token), expires_in:\(expires_in), uid:\(uid): expires_date:\(expires_date), name:\(name), avatar_large:\(avatar_large)"
    }
    
    
    static  let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/Account.plist"
    //保存自己的方法
    
    //哪一个对象调用就将哪一个对象保存到归档路径当中
    func saveAccount() {
        
        NSKeyedArchiver.archiveRootObject(self, toFile: GZDUserAccount.accountPath)
    }
    //解档的方法
    //声明1个属性来把用户的账号信息保存到内存中
   private static var userAccount : GZDUserAccount?
    class func loadAccount() -> GZDUserAccount? {
        
        if userAccount == nil
        {
            userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? GZDUserAccount
            
        }
        //如果账号不为空 并且有效日期比当前日期要大 那么就返回账号,
        if userAccount != nil && userAccount?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending{
            
            
            return userAccount
        }
        
        
        return nil
    }
    //    result :[String : AnyObject]?,error: NSError?) -> (Void)
    func loadUserInfo(finished :(error: NSError?) -> (Void)) {
        
        GZDNetworkTools.sharedInstance.loadUserInfo { (result, error) -> (Void) in
            if result  == nil || error != nil{
            
                finished(error: error)
                
                return

            }
            //保存用户信息
            print("加载成功")
            self.avatar_large = result!["avatar_large"] as? String
            self.name = result!["name"] as? String
            //保存到沙盒
//               print("\(__FUNCTION__) \(self)")
            //            print(" \(__FUNCTION__)\(NSThread.currentThread())")
            self.saveAccount()
            //给缓存变量赋值
            GZDUserAccount.userAccount = self
            
            finished(error: nil)
        }
        
    }
    
    //MARK: - 归档和解档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        
    }
    
    
    
}

