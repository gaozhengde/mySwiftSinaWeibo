//
//  GZDHomeTableViewController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/26.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
import SVProgressHUD


class GZDHomeTableViewController: GZDBaseTableViewController {
    
    //微博数据数组
    
    private var statuses : [GZDStatus]? {
        
        didSet{
            
            tableView.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //判断是否登录如果没有登录 那么就直接返回
        
        if !GZDUserAccount.isUserAccountLogin() {
            return
        }
        
        
        setupNavigationBar()
        
        //发送网络请求获取微博数据
    
        GZDStatus.loadStatus { (statuses, error) -> () in
            print("statuses = \(statuses)")
            if error != nil{
                SVProgressHUD.showErrorWithStatus("加载数据失败", maskType: SVProgressHUDMaskType.Black)
                return
            }
            if statuses?.count == 0 || statuses == nil{
                
                SVProgressHUD.showErrorWithStatus("没有新的微博数据", maskType: SVProgressHUDMaskType.Black)
                return
            }
            //来到这里说明有数据,定义1个属性记录 数据 然后在属性监视器里面刷新tableView
            //现在就有数据了
            self.statuses = statuses
        }
        
        
        
    }
    
    private func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        let button = GZDHomeTitleButton()
        
        button.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        
        //这个title从哪里来  从userAccount里面
        
        let title = GZDUserAccount.loadAccount()?.name ?? "没有名称"
        
        button.setTitle(title, forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(16)
        
        button.sizeToFit()
        
        // 添加Button的单击时间
        
        button.addTarget(self, action: "titleButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.titleView = button
        
    }
    
    @objc private func titleButtonClick(button:GZDHomeTitleButton) {
        
        //点击以后让按钮旋转
        
        button.selected = !button.selected
        
        let transform = button.selected == true ? CGAffineTransformMakeRotation(CGFloat(M_PI) - 0.01):CGAffineTransformIdentity
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            button.imageView?.transform = transform
        })
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
