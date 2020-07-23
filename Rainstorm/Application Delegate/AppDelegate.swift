//
//  AppDelegate.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


     var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension AppDelegate{
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

func getWindow() -> UIWindow?{
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
       if #available(iOS 13, *) {
           let scenceDelegate =  UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
           return scenceDelegate?.window
       }
       return appDelegate?.window
}
@discardableResult
func changeRootViewController(storyboardId: String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let initialVC = storyboard.instantiateViewController(withIdentifier: storyboardId)
    let navigationController = UINavigationController(rootViewController: initialVC)
    getWindow()?.rootViewController = navigationController
    getWindow()?.makeKeyAndVisible()
    return initialVC
}
