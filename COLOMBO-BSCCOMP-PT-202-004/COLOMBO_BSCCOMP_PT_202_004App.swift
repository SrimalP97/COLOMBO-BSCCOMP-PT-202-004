//
//  COLOMBO_BSCCOMP_PT_202_004App.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-07.
//

import SwiftUI
import UIKit
import Firebase


@main
struct COLOMBO_BSCCOMP_PT_202_004App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {

 var window: UIWindow?

func application(_ application: UIApplication,
   didFinishLaunchingWithOptions launchOptions:
                 [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   FirebaseApp.configure()

    return true
 }
}
