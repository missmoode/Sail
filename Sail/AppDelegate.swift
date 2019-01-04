//
//  AppDelegate.swift
//  Sail
//
//  Created by Amy Harris on 21/08/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private func setInitialViewController(_ viewController: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        
        if (Stores.sessionStore.state.sessionsList.count == 0) {
            setInitialViewController(UIStoryboard(name: "Setup", bundle: nil).instantiateInitialViewController()!)
        } else
        if (Stores.sessionStore.state.currentSession == nil) {
            Stores.sessionStore.dispatch(.setCurrent(Stores.sessionStore.state.sessionsList.first!))
        } else {
            setInitialViewController(UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!)
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let host = components.host,
            let path = components.path,
            let params = components.queryItems else {
                print("Invalid URL or path missing")
                return false
        }
        
        switch (host + path) {
        case "oauth/addToken":
            let token = (params.first(where: { $0.name == "token" })?.value)!
            let address = (params.first(where: { $0.name == "address" })?.value)!
            LoginController.ingestToken(instance: address, token: token)
            return true
        default:
            return false
        }
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

    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    }

}

