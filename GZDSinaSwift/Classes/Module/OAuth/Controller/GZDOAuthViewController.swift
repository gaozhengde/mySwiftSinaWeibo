//
//  GZDOAuthViewController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/28.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking



class GZDOAuthViewController: UIViewController {
    
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        
        view = webView
        
        webView.delegate = self
    }
    /*
    
    App Key：1066022621
    App Secret：5392a909fa7fd77d606bfe9e6a2bbdb9
    授权回调页：http://www.baidu.com
    取消授权回调页：http://www.baidu.com/cancel
    client_id	申请应用时分配的AppKey。
    redirect_uri  授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    */
    
    let client_id = "1066022621"
    
    let redirect_uri = "http://www.baidu.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlRequest = NSURLRequest(URL:GZDNetworkTools.sharedInstance.oauthUrl())
        
        webView.loadRequest(urlRequest)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnClick")
        
    }
    
    func cancelBtnClick() {
        
        dismissViewControllerAnimated(true) { () -> Void in
            //消失完成回调
        }
        //同时也要关闭加载遮罩
        
        SVProgressHUD.dismiss()
    }
    
    
    
    
}

//webView 代理方法

extension GZDOAuthViewController: UIWebViewDelegate{
    //开始加载请求
    func webViewDidStartLoad(webView: UIWebView) {
        //显示正在加载
        SVProgressHUD.showWithStatus("正在玩命加载中...", maskType: SVProgressHUDMaskType.Gradient)
        
    }
    //加载请求完毕
    func webViewDidFinishLoad(webView: UIWebView) {
        //关闭progressHUD
        SVProgressHUD.dismiss()
    }
    
    //询问是否加载 request
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL!.absoluteString
        //在单例里面有写
        if !urlString.hasPrefix(GZDNetworkTools.sharedInstance.redirect_uri) {
            
            return true
        }
        
        //去掉回调地址和问号之后的那个字符串
        if let queryStr  = request.URL?.query{
            
            let codeStr = "code="
            
            if queryStr.hasPrefix(codeStr){
                
                let NSQuery = queryStr as NSString
                //从多少长度开始截取
                let code = NSQuery.substringFromIndex(codeStr.characters.count)
                print("\(code)")
                //有了code 就可以获取accesstoken
                loadRequest(code)
                
            } else{  //没有code 开头就是点击了取消
            }
            
        }
        //如果加载的不是回调地址 就让他去加载, 不能让用户看到回调的地址
        return false
    }
    
    //层次嵌套有点深 再定义1个方法来加载
    
    func loadRequest(code: String) {
        //拿到工具类
        
        GZDNetworkTools.sharedInstance.loadRequest(code) { (result, error) -> (Void) in
            if error != nil || result == nil{
//                SVProgressHUD.showErrorWithStatus("加载网络请求失败", maskType: SVProgressHUDMaskType.Black)
//                //还要延迟关闭控制器
//
//             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
//                self.cancelBtnClick()
//             })
//
                self.netError("加载网络失败...")
            }else{
//                SVProgressHUD.showSuccessWithStatus("加载成功.")
                    print("result: \(result)")
                
                let account = GZDUserAccount(dict: result!)
                
                //拿到account 就保存到归档路径文件
                account.saveAccount()
                
                account.loadUserInfo({ (error) -> (Void) in
                    
                    if error != nil{
                        self.netError("加载用户信息失败..")
                    }else{
                        
                        print("waimian\(account)")
                        
                        ///关闭控制器
                        self.cancelBtnClick()
                    }
                    
                })
            }
           
        }
    }
    
    private func netError(errorMessage : String){
        
        SVProgressHUD.showErrorWithStatus(errorMessage, maskType: SVProgressHUDMaskType.Black)
        //还要延迟关闭控制器
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            self.cancelBtnClick() })
    }
    
    
    
}

