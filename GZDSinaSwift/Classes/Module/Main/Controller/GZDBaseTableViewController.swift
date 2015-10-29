//
//  GZDBaseTableViewController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/26.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit


extension GZDBaseTableViewController: GZDVisitorViewDelegate {
    
    ///登录View即将登录
    func visitorViewWillLogin() {
        
        let oauthController = GZDOAuthViewController()
        
        //包装1个导航控制器 坐上角是取消
        
        let oauthNav = UINavigationController(rootViewController: oauthController)
        
        presentViewController(oauthNav, animated: true) { () -> Void in
            
        }
    }
    ///登录View 即将注册
    func visitorViewWillRegister() {

        visitorViewWillLogin()
    }
    
}


class GZDBaseTableViewController: UITableViewController {

    let userLogin = false
    
    var visitorView = GZDVisitorView()
    
    override func loadView() {
        
        userLogin ? super.loadView() : setupVisitorView()
        
    }
    
    ///设置替换的 visitorView
    func setupVisitorView(){
        
        view = visitorView
        
        visitorView.delegate = self
        
        if self is GZDHomeTableViewController {
            visitorView.startRotationAnimation()
            
            NSNotificationCenter.defaultCenter() .addObserver(self, selector: "didEnterBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "didBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
            
            
        }else if self is GZDMessageTableViewController{
            visitorView.setUpSelf("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }else if self is GZDProfileTableViewController{
            visitorView.setUpSelf("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        }else if self is GZDDiscoverTableViewController{
            visitorView.setUpSelf("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }
        
        //设置全局的navigationitem  
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "leftBarButtonClick")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Done, target: self, action: "rightBarButtonClick")
        
        
}
    //MARK: - 通知方法
    
    func didEnterBackground(){
        //暂停动画
        (view as! GZDVisitorView).pauseAnimation()
    }
    
    func didBecomeActive() {
        //继续动画
        
         (view as! GZDVisitorView).resumeAnimation()
        
    }
    
    
    
    func leftBarButtonClick() {
    
        print(__FUNCTION__)
    }

    func rightBarButtonClick() {
        print(__FUNCTION__)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
