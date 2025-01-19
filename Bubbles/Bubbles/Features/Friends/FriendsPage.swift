//
//  FriendsPage.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//

import SwiftUI

struct FriendsPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Want to shower?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding()
            .navigationTitle("Friends")
        }
    }
}

struct FriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsPage()
    }
}
