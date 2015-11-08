//
//  GZDHomeTableViewController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/26.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
import SVProgressHUD

enum GZDHometableViewCellIdentify :String {
    case GZDNormalCell = "GZDNormalCell"
    case GZDForwardCell = "GZDForwardCell"
}

class GZDHomeTableViewController: GZDBaseTableViewController {
    
    //微博数据数组
    
    private var statuses : [GZDStatus]? {
        
        didSet{
            
            tableView.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(backgroundView)
        
        refreshControl = GZDRefreshControl()
        
        //在tableView FooterView 里面添加上拉加载更多view
         tableView.tableFooterView = pullUpView
        
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        
        refreshControl?.beginRefreshing()
        
        //代码触发开始刷新
        refreshControl?.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        //        if  refreshControl?.refreshing == true{
        //            loadData()
        //        }
        
        //判断是否登录如果没有登录 那么就直接返回
        
        if !GZDUserAccount.isUserAccountLogin() {
            return
        }
        //注册cell
        
        tableView.registerClass(GZDNormalCell.self, forCellReuseIdentifier:GZDHometableViewCellIdentify.GZDNormalCell.rawValue)
        
        tableView.registerClass(GZDForwardCell.self, forCellReuseIdentifier: GZDHometableViewCellIdentify.GZDForwardCell.rawValue)
        
        setupNavigationBar()
        
        //                tableView.rowHeight = 300
        tableView.estimatedRowHeight = 300
        
        //        tableView.rowHeight = UITableViewAutomaticDimension

        //        tableView.rowHeight = 500
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //发送网络请求获取微博数据
        
        //不主动调用加载数据
        //            loadData()
        
        
    }
    
    func loadData(){
        
        
        var since_id = statuses?.first?.id ?? 0
        var max_id = 0
        
        if pullUpView.isAnimating(){
            since_id = 0
            max_id = statuses?.last?.id ?? 0
            
        }
        
        
        GZDStatus.loadStatus(since_id, max_id: max_id) { (statuses, error) -> () in
            //        GZDStatus.loadStatus (since_id : Int,max_id :Int) { (statuses, error) -> () in
            //            print("statuses = \(statuses)")
            if error != nil{
                SVProgressHUD.showErrorWithStatus("加载数据失败", maskType: SVProgressHUDMaskType.Black)
                return
            }
            //先排除上拉加载
            if since_id > 0 {
                let count = statuses?.count ?? 0
                self.showTipView(count)
            }
            
            
            
            if statuses?.count == 0 || statuses == nil{
                
                SVProgressHUD.showErrorWithStatus("没有新的微博数据", maskType: SVProgressHUDMaskType.Black)
                
                //关闭下拉刷新控件
                self.refreshControl?.endRefreshing()
                
                //关闭上拉加载更多
                
                self.pullUpView.stopAnimating()
                return
            }
            //来到这里说明有数据,定义1个属性记录 数据 然后在属性监视器里面刷新tableView
            //现在就有数据了
            //            if  statuses?.count == 0 {
            //                return
            //            }
            
            self.refreshControl?.endRefreshing()
            
            if since_id > 0 {
                
                self.statuses = statuses! + self.statuses!
                
                print("下拉刷新 获取的新数据")
               
                
            }else if max_id > 0{
                
                self.statuses = self.statuses! + statuses!
                
            }else{
                self.statuses = statuses
            }
            
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
    //
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //拿到cell
        let status = statuses![indexPath.row]
        
        let identify = status.homeCellIdentify()
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify) as! GZDHomeCell
        //先去缓存池里面取
        if let rowHeight = status.rowHeight {
            //            print("缓存 rowHeight \(rowHeight)")
            return rowHeight
        }
        
        let rowHeight = cell.rowHeight(status)
        //关键在于怎么去获得拿到 cell的 bottomview 的最大的Y值 就是cell的行高
        //没有值
        status.rowHeight = rowHeight
        //        print("创建rowHeight\(rowHeight)")
        return rowHeight
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        super.tableView(tableView, numberOfRowsInSection: section)
        //        print("我是子类的方法")
        //如果有就返回1数据 如果没有数据就返回0
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let status = statuses![indexPath.row]
        
        let identify = status.homeCellIdentify()
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify) as! GZDHomeCell
        //    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! GZDHomeCell
        //        print("\()")
        
        cell.status = status
        //        cell.textLabel?.text = statuses?[indexPath.row].text
        
        //现在有了模型数组了 就要开始显示内容
        //到最后一条的时候
        
        if indexPath.row == (statuses?.count)! - 1 && !pullUpView.isAnimating(){
            //加载更多数据
            pullUpView.startAnimating()
            //取到比maxid 要下的微博
                loadData()
        }
        
        
        return cell
    }
    
    //懒加载 下拉刷新背景view
//    private let backgroundView : UIButton = {
//        
//    
//    
//    }()
    
    
    //显示加载了多少条数据
    private func showTipView (count : Int) {
        let tipLabelHeight : CGFloat = 44
        let tipLabel = UILabel()
        tipLabel.frame = CGRectMake(0, -20 - tipLabelHeight, UIScreen.width(), 44)
        tipLabel.textColor = UIColor.whiteColor()
        tipLabel.backgroundColor = UIColor.orangeColor()
        tipLabel.font = UIFont.systemFontOfSize(16)
        tipLabel.textAlignment = NSTextAlignment.Center
        tipLabel.text = count == 0 ? "没有新的微博" : "加载了\(count)条微博"
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)
        let duration = 0.75
        
    UIView.animateWithDuration(duration, animations: { () -> Void in
        
        tipLabel.frame.origin.y = tipLabelHeight
        
        }) { (_) -> Void in
            //再执行1个uiview 动画
            UIView.animateWithDuration(duration, delay: 0.3, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                
                tipLabel.frame.origin.y = -20 - tipLabelHeight
                
                }, completion: { (_) -> Void in
                    //移除
                    tipLabel.removeFromSuperview()
            })
            
            
        }
        
//        //1搞1个view 放在最上面
//        let backgroundView = UIButton(type: UIButtonType.Custom)
////        let backgroundViewHeight : CGFloat = 44.0
//        backgroundView.frame = CGRect(x: 0, y: -108, width: UIScreen.width(), height: 44)
//        backgroundView.backgroundColor = UIColor.orangeColor()
//        backgroundView.titleLabel?.textColor = UIColor.whiteColor()
//      
//        backgroundView.setTitle("加载了\(count)条数据", forState: UIControlState.Normal)
//        view.addSubview(backgroundView)
//
//        //2加载完数据之后让view 显示出来 0.25秒之内
//        
//        
//        UIView.animateWithDuration(0.25, delay: 2, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
//           backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.width(), height: 44)
//            
//            }) { (_) -> Void in
//                UIView.animateWithDuration(0.25, animations: { () -> Void in
//                        backgroundView.frame = CGRect(x: 0, y: -108, width: UIScreen.mainScreen().bounds.width, height: 44)
//                })
//        }
        
        //3停留1秒钟 然后再让view  缩回去
        
    }
  
    //上拉加载更多
    private let pullUpView :UIActivityIndicatorView = {
        
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        //颜色
        indicatorView.color = UIColor.redColor()
        
        return indicatorView
        
    }()
    
    
    
    
    
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
