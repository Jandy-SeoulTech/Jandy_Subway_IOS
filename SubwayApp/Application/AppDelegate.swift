//
//  AppDelegate.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/05/01.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /**
         * 현재 윈도우의 루트 뷰 컨트롤러가 ViewController로 되어있습니다.
         * 이 부분에서 앱 처음 사용 시 rootViewController를 온보딩 ViewController로 바꾸면 됩니다.
         */
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController(rootViewController: SearchViewController())
        window.rootViewController = navVC
        //window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
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

