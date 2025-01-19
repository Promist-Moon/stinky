//
//  SignUpPage.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//


import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SignUpPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignedUp: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToMain: Bool = false

    var body: some View {
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
        }
        .padding()
        .navigationTitle("Sign Up")
        .background(
            // Programmatic navigation using state variables
            Group {
                if navigateToMain {
                    ContentView() // Navigate to main content
                }
            }
        )
    }
    
    private func handleSignUp() {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Please fill in both fields"
            showAlert = true
            return
        }

        // Firebase authentication: create a new user with email and password
        Auth.auth().createUser(withEmail: username, password: password) { result, error in
            if let error = error {
                self.errorMessage = "Error: \(error.localizedDescription)"
                self.isSignedUp = false
            } else {
                // User created successfully
                self.isSignedUp = true
                self.errorMessage = "Sign up successful"

                // Save user details to Firestore
                if let user = result?.user {
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "username": self.username,
                        "email": self.username,
                        "createdAt": Timestamp(date: Date())
                    ]) { error in
                        if let error = error {
                            print("Error saving user data: \(error.localizedDescription)")
                        } else {
                            print("User data saved successfully")
                        }
                    }
                }
            }
            self.showAlert = true
        }
    }
}
