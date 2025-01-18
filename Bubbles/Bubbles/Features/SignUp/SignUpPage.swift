//
//  SignUpPage.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//


import SwiftUI

struct SignUpPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignedUp: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToMain: Bool = false
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()

                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    handleSignUp()
                }) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Sign Up Status"),
                          message: Text(errorMessage),
                          dismissButton: .default(Text("OK")) {
                              if isSignedUp {
                                  navigateToMain = true
                              }
                          })
                }

                NavigationLink(destination: ContentView(), isActive: $isSignedUp) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Sign Up")
        }
    }
    
    private func handleSignUp() {
        let users = userManager.loadUsers()
        
        if users.first(where: { $0.username == username }) != nil {
            // If user exists, tell them to login
            errorMessage = "Username already exists. Proceed to login"
            showAlert = true
            return
        } else {
            // If user does not exist, sign up
            let newUser = User(id: UUID(), username: username, password: password, friends: [], lastShowerDate: nil)
            var users = userManager.loadUsers()
            users.append(newUser)
            userManager.saveUsers(users)
            isSignedUp = true
            errorMessage = "Sign up successful"
        }
        showAlert = true
    }
}
