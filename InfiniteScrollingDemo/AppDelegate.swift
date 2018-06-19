//
//  AppDelegate.swift
//  InfiniteScrollingDemo
//
//  Created by Pawel Milek on 16/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    setStatusBar()
    setNavigationBar()
    setTabBar()
    return true
  }
}


// MARK: - Set style
private extension AppDelegate {
  
  func setStatusBar() {
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
  func setNavigationBar() {
    UINavigationBar.appearance().barTintColor = .red
    UINavigationBar.appearance().tintColor = .black
  }
  
  func setTabBar() {
    UITabBar.appearance().barTintColor = .red
    UITabBar.appearance().tintColor = .black
  }
  
}

