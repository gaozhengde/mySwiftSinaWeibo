//
//  GZDNetworkTools.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/27.
//  Copyright © 2015年 高正德. All rights reserved.
//

import AFNetworking

class GZDNetworkTools:AFHTTPSessionManager  {
    
//单例
    static let sharedInstance: GZDNetworkTools = {
        
        let baseUrl = NSURL(string: "https://api.weibo.com/")!
        
        let tools = GZDNetworkTools(baseURL: baseUrl)
        
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
        
    }()
    //MARK: - OAtuh授权 
    /*
    
    App Key：1066022621
    App Secret：5392a909fa7fd77d606bfe9e6a2bbdb9
    授权回调页：http://www.baidu.com
    取消授权回调页：http://www.baidu.com/cancel
    
    */
    //申请应用时分配的appkey
    private let client_id = "1066022621"

    //申请应用时分配的appsecret
    private let client_secret = "5392a909fa7fd77d606bfe9e6a2bbdb9"
    
    private let grant_type = "authorization_code"
    
    //回调地址
    let redirect_uri = "http://www.baidu.com"
    
    func oauthUrl() -> NSURL{
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        return NSURL(string: urlString)!
    }
//    "oauth2/access_token"
    //使用工具类来发送网络请求  使用闭包回调
    
    func loadRequest(code: String,finished: (result: [String:AnyObject]?,error : NSError?) -> (Void)) {
        
        let urlString = "oauth2/access_token"
        
        
        let parameters = [
        
            "client_id":client_id,
            "client_secret":client_secret,
            "redirect_uri":redirect_uri,
            "grant_type":grant_type,
            "code":code
        ]
        
        //搞1个闭包回调
        POST(urlString, parameters: parameters, success: { (_, request) -> Void in
//            print("\(request)")
            //执行这个闭包
            //强转成字典
            
            
            finished(result: request as? [String:AnyObject], error: nil)
            
            }) { (_, error: NSError) -> Void in
//                print("\(error)")
                finished(result: nil, error: error)
        }
        
    }
}
