//
//  AppDelegate.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/26.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //      print("\(GZDUserAccount.loadAccount())")
        
        
        window = UIWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        
        
        
        
        
        //        let tabBarController = GZDTabBarController()
        
        
        //        window?.rootViewController = tabBarController
        
        //        let welcomeController = GZDWelcomeViewController()
        
        //        window?.rootViewController = GZDOAuthViewController()
        
                window?.rootViewController = defaultController()
        
        
//        window?.rootViewController = GZDNewFeatureViewController()
        
        window?.makeKeyAndVisible()
        
        self.setupAppearance()
        
        //        print(isNewVersion())
        
        return true
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
    }
    
    private func defaultController() -> UIViewController{
        
        if !GZDUserAccount.isUserAccountLogin(){
            
            return GZDTabBarController()
//            return GZDBaseTableViewController()
        }
        
        return isNewVersion() ? GZDNewFeatureViewController() : GZDWelcomeViewController()
    }
    
    
    ///判断是否是新版本
    
    func isNewVersion() -> Bool{
        
        //获取 当前版本号
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let currentVersionNum = Double(currentVersion)!
        
        //获取沙盒版本号
        let sandBoxVersionNum = NSUserDefaults.standardUserDefaults() .doubleForKey("sandBoxVersion")
        
        
        //保存当前版本号
        
        NSUserDefaults.standardUserDefaults() .setDouble(currentVersionNum, forKey: "sandBoxVersion")
        
        
        //比较两个版本号 如果当前版本号 > 沙盒版本号就返回true
        return currentVersionNum > sandBoxVersionNum
    }
    
    func switchController (isMain:Bool){
        
        window?.rootViewController = isMain ? GZDTabBarController() : GZDWelcomeViewController()
        
        
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

