//
//  GZDStatus.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/1.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
import SDWebImage
class GZDStatus: NSObject {
    
    
    /// 微博创建时间
    var created_at: String?
    
    /// 字符串型的微博ID
    var idstr: String?
    
    var id : Int = 0
    
    /// 微博信息内容
    var text: String?
    
    /// 微博来源
    var source: String?
    
    /// 微博的配图
    var pic_urls: [[String: AnyObject]]? {
        
        //给他赋值的时候要拿出 配图数组的url
        didSet{
            
            if pic_urls?.count == 0{
                return
            }
            //走到下面来说明是有值的
            
            pictureUrls = [NSURL]()
            for dict:[String:AnyObject] in pic_urls! {
                if let urlString = dict["thumbnail_pic"] as? String{
                    
                    pictureUrls?.append(NSURL(string: urlString)!)
                }
            }
        }
    }
    ///配图的 url数组
    var pictureUrls : [NSURL]?
    
    var urls : [NSURL]? {
        get {
            return retweeted_status == nil ? pictureUrls : retweeted_status?.pictureUrls
        }
    }
    /// 用户模型
    var user : GZDUser?
    
    //缓存的行高
    var rowHeight : CGFloat?
    
    var retweeted_status : GZDStatus?
    
    func homeCellIdentify () -> String{
        
        return retweeted_status == nil ? GZDHometableViewCellIdentify.GZDNormalCell.rawValue : GZDHometableViewCellIdentify.GZDForwardCell.rawValue
        
        
    }
    
    
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
                //完成 转发微博的字典转模型
            }
        }else if key == "retweeted_status" {
            
            if let dict = value as? [String:AnyObject] {
                
                retweeted_status = GZDStatus(dict: dict)
                
            }
            return
        }
        
        return super.setValue(value, forKey: key)
    }
    
    /// 缓存微博图片
    class func cacheWebImage(lists:[GZDStatus],finished: (list:[GZDStatus]?,error:NSError?) -> Void) {
        //定义任务组
        let group = dispatch_group_create()
        
        //记录下载图片的大小
        
        var length = 0
        
        //遍历模型数组
        for status in lists  {
            
            //获取到微博模型里面的配图的url
            
            guard let urls = status.urls else{
                
                continue
            }
            
            //再遍历图片数组
            
            if urls.count == 1{
                
                let url = urls.first
                dispatch_group_enter(group)
                
                //使用sdwebimage 下载图片
                
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image, error, _, _, _) -> Void in
                    //离开任务组
                    
                    dispatch_group_leave(group)
                    
                    if error != nil{
                        print("\(error)")
                        return
                    }
                    
                    //来到这里说明没有出错
                    
                    print("下载完成")
                    
                    if let data = UIImagePNGRepresentation(image){
                        length += data.length
                    }
                })
                
            }
            
            
        }
        //下载完成所有图片通知调用者 微博数据加载完成
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            finished(list: lists, error: nil)
        }
        
        
        
    }
    
    
    
    //打印的方法
    
    override var description : String {
        
        let parameters = ["created_at","idstr","text","source","pic_urls"]
        
        return "\n\t:\(dictionaryWithValuesForKeys(parameters))"
    }
    
    //发送网络请求 并且字典转模型的工作由模型来关心
    
    class func loadStatus (since_id : Int,max_id :Int,finished:(statuses:[GZDStatus]?,error:NSError?) -> ()) {
        
        //加载网络请求  返回微博数据
        GZDNetworkTools.sharedInstance.loadStauts (since_id,max_id: max_id) { (result, error) -> (Void) in
            
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
                
                //缓存图片
            cacheWebImage(finalArray, finished: finished)
                
                finished(statuses: finalArray, error: nil)
                
                return
            }
            finished (statuses: nil, error: error)
            
        }
    }
    
    
    
    
    
    
    
}











