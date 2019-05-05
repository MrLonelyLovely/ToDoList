//
//  AppDelegate.swift
//  ToDoList
//
//  Created by 陈沛 on 2019/4/24.
//  Copyright © 2019 陈沛. All rights reserved.
//

//在iOS系统中，应用都存在独立的沙箱中（sandbox）原因是苹果为了确保设备的使用安全。
//这样可以防止恶意应用获取其他应用所存储的数据（比如网银数据），或者是试图去执行一些非法操作（安卓中的root）
//每个应用都拥有存储文件和文档的文件夹，它们可以随意读取自己的文件夹，但是绝对无法读取其他应用的文件或文档文件夹

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //当应用启动时会调用该方法，其调用级别要高于初始（Initial）视图控制器的viewDidLoad()方法
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions")
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        return true
    }

    /*
     当应用在前台运行时，如果有电话打进来就会调用该方法。
     在用户选择接听电话后，我们可以在该方法中执行相关指令防止用户数据丢失。
     比如用户正在应用中填写表单时有电话打进来，我们可以在该方法中将数据保存到本地。
 */
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    /*
     在应用的界面从屏幕上消失时就会调用该方法。
     比如当用户按Home键，或者是打开了另一个不同的应用，这也就意味着我们的应用进入了后台。
 */
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    /*
     当应用被用户或系统终止运行或系统需要回收宝贵的内存资源时就会调用该方法。
     （在更新应用或更新iOS系统时，也会终止应用程序的运行）
 */
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate")
    }


}

