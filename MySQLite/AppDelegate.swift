//
//  AppDelegate.swift
//  MySQLite
//
//  Created by sqluo on 2017/1/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//



/*
 1.需要在 TARGETS->Build Phases->Link Binary With Libraries 中添加 libsqlite3.tbd
 2.创建桥接文件，在桥接文件中导入 #import <sqlite3.h>
 3.导入 SQLManager文件夹中的文件
 4.需要写一个表的model，SQLManger.swift 中的创建一系列方法中 改成跟model一致
 5.可以使用了
*/



import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let rootVC = RootViewController()
        let nav = BaseNavigationController(rootViewController: rootVC)
        
        nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        nav.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        
        self.window?.rootViewController = nav
        
     
        SQLManager.shareInstance().openDB(DBName: "BLOB.sqlite")
 

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

