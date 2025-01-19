//
//  BubblesApp.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//
import SwiftUI

@main
struct BubblesApp: App {
    @StateObject private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            LoginPage() // This is where the ContentView is displayed
                .environmentObject(userManager)
        }
    }
}
