//
//  AppDelegate.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 21/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import UIKit
import ReSwift

let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

