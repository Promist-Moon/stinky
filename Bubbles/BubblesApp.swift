//
//  BubblesApp.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//
//import SwiftUI
//
//@main
//struct BubblesApp: App {
//    @StateObject private var userManager = UserManager()
//    
//    var body: some Scene {
//        WindowGroup {
//            LoginPage() // This is where the ContentView is displayed
//                .environmentObject(userManager)
//        }
//    }
//}

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
  }
}
