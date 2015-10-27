//
//  GZDTabBarController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/26.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //两种方法 选择tabbar上面的内容的颜色
        //1.tabbar.tintColor
   
        
        //首页
        let homeVC = GZDHomeTableViewController()
        addChildViewController(homeVC, title: "首页", imageName: "tabbar_home")
        
        //发现
        let discoverVC = GZDDiscoverTableViewController()
        addChildViewController(discoverVC, title: "发现", imageName: "tabbar_discover")
        
        //消息
        let messageVC = GZDMessageTableViewController()
        addChildViewController(messageVC, title: "消息", imageName: "tabbar_message_center")
        
        
        
        let profileVC = GZDProfileTableViewController()
        addChildViewController(profileVC, title: "我", imageName: "tabbar_profile")
        
        
        let tabBar = GZDTabBar()
        
        setValue(tabBar, forKey: "tabBar")
        
//        tabBar.tintColor = UIColor.orangeColor()

    }

    
    func addChildViewController(controller: UIViewController ,title: String,let imageName : String) {
        
        let nav = UINavigationController(rootViewController: controller)
        
        controller.tabBarItem.title = title
        
        controller.navigationItem.title = title
        
        controller.tabBarItem.image = UIImage(named: imageName)
        
        let selectedImageName = imageName + "_selelcted"
        
        controller.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        
        addChildViewController(nav)
        
    }
    
   
}
