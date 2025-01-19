import UIKit
import SwiftUI
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Firebase
        FirebaseApp.configure()
        
        // Set up the initial view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create a UIHostingController with your SwiftUI view
        let loginView = LoginPage()
        let hostingController = UIHostingController(rootView: loginView)
        
        // Set the rootViewController of the window
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
        
        // Optional: Print a message to verify Firebase initialization
        print("Firebase initialized successfully")
        
        return true
    }
}
