//
//  GZDNetworkTools.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/27.
//  Copyright © 2015年 高正德. All rights reserved.
//

import AFNetworking

//枚举来搞错误信息

enum GZDErrorINfo: Int {
    
    case accessTokenError = -1
    case uidError = -2
    
    var description :String {
        
        get{
            switch self{
                
            case GZDErrorINfo.accessTokenError:
                return "没有accesstoken"
            case GZDErrorINfo.uidError:
                return "没有uid"
            }
        }
    }
    //在枚举里面定义方法
    
    func error() -> NSError{
        
        return NSError(domain: "www.gzd.network", code: rawValue, userInfo: ["description" : description])
    }
    
}

class GZDNetworkTools:NSObject  {
    
    //单例
    //    static let sharedInstance: GZDNetworkTools = {
    //
    //        let baseUrl = NSURL(string: "https://api.weibo.com/")!
    //
    //        let tools = GZDNetworkTools(baseURL: baseUrl)
    //
    //        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
    //
    //        return tools
    //
    //    }()
    
    //单例新
    
    static let sharedInstance : GZDNetworkTools = GZDNetworkTools()
    
    override init() {
        
        manager = AFHTTPSessionManager(baseURL: NSURL(string: "https://api.weibo.com/"))
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
    }
    
    private let manager : AFHTTPSessionManager
    
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
    
    func loadRequest(code: String,finished: netWorkCallBack) {
        
        let urlString = "oauth2/access_token"
        
        
        let parameters = [
            
            "client_id":client_id,
            "client_secret":client_secret,
            "redirect_uri":redirect_uri,
            "grant_type":grant_type,
            "code":code
        ]
        
        //搞1个闭包回调
        
        netWorkPost(urlString, parameters: parameters) { (result, error) -> (Void) in
            
            finished(result: result, error: error)
        }
        
        //      manager.POST(urlString, parameters: parameters, success: { (_, request) -> Void in
        ////            print("\(request)")
        //            //执行这个闭包
        //            //强转成字典
        //
        //
        //            finished(result: request as? [String:AnyObject], error: nil)
        //
        //            }) { (_, error: NSError) -> Void in
        ////                print("\(error)")
        //                finished(result: nil, error: error)
        //        }
        //
    }
    
    //MARK: - 发送网络请求获取用户信息
    func loadUserInfo(finished : netWorkCallBack) -> (Void){
        
        
        //守卫 如果没有值 就会执行后面的代码 比
        guard var parameters =  accessToken() else {
            
            let accessTokenError = GZDErrorINfo.accessTokenError.error()
            
            //            let error = NSError(domain: "www.gzd.net", code: accessTokenError.rawValue, userInfo: ["description" : accessTokenError.description])
            
            finished(result: nil, error: accessTokenError)
            print("\(accessTokenError)")
            return

        }
        
//        if GZDUserAccount.loadAccount()?.access_token == nil {
//            //access_token 为空
//            //定义错误信息
//                    }
        
        if GZDUserAccount.loadAccount()?.uid == nil {
            
            
            let uidError = GZDErrorINfo.uidError.error()
            //        let error = NSError(domain: "www.gzd.net", code: uidError.rawValue, userInfo: ["description" : uidError.description])
            
            finished(result: nil, error: uidError)
            
            print("\(uidError)")
            return
        }
        
//        let parameters = [
//            
//            "access_token" :GZDUserAccount.loadAccount()!.access_token!,
//            "uid": GZDUserAccount.loadAccount()!.uid!
//        ]
        parameters["uid"] = GZDUserAccount.loadAccount()!.uid!
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        netWorkGet(urlString, parameters: parameters) { (result, error) -> (Void) in
            
            finished(result: result, error: error)
        }
        
        
        //    manager.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
        //
        ////            print("result = \(result)")
        //
        //            finished(result: result as? [String :AnyObject], error: nil)
        //
        //            }) { (_, error: NSError) -> Void in
        ////                 print("error = \(error)")
        //                finished(result: nil, error: error)
        //        }
    }
    
    //搞1个方法来判断 accessToken 是否为空 如果不为空就返回1个字典
    
    func accessToken() ->[String : AnyObject]?{
        
        let accessToken = GZDUserAccount.loadAccount()?.access_token
       
        if accessToken == nil{
        
            return nil
        }
        //这里一定要这样拆 不能只拆1个 不然就加载不出数据
        //TODO:这里一定要这样拆 不能只拆1个 不然就加载不出数据
       return ["access_token" :GZDUserAccount.loadAccount()!.access_token!]
    }
    
    
    //发送网络请求获取微博数据
    func loadStauts(finished : netWorkCallBack){
        
        let urlString = "/2/statuses/home_timeline.json"
        
        guard var parameters = accessToken() else{
            //如果token没有值 也要告诉调用者
            
            finished(result: nil, error: GZDErrorINfo.accessTokenError.error())
                return
        }
        
//        if let access_token = GZDUserAccount.loadAccount()?.access_token {
            // count	false	int	单页返回的记录条数，最大不超过100，默认为20。
            
//            let parameters = [
//                "access_token" : access_token,
//                "count" : 1
//            ]
        parameters["count"] = 1
        
            netWorkGet(urlString, parameters: parameters, finished: finished)
//        }
    }
    
    
    typealias netWorkCallBack = (result :[String:AnyObject]?,error :NSError?) -> (Void)
    ///封装定义的网络工具类发送GET网络请求方法
    func netWorkGet (URLString: String, parameters: AnyObject?, finished : netWorkCallBack){
        
        
        manager.GET(URLString, parameters: parameters, success: { (_, result) -> Void in
            
            finished(result: result as? [String : AnyObject], error: nil)
            
            }) { (_, error) -> Void in
                
                finished(result: nil, error: error)
        }
    }
    ///封装定义的网络工具类发送POST网络请求方法
    func netWorkPost (URLString: String, parameters: AnyObject?,finished : netWorkCallBack) -> (Void) {
        
        manager.POST(URLString, parameters:parameters, success: { (_, result) -> Void in
            
            finished(result: result as? [String : AnyObject], error: nil)
            
            }) { (_, error) -> Void in
                
                finished(result: nil, error: error)
        }
        
    }
}
