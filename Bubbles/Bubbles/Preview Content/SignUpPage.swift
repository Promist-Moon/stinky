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
    @State private var isLoginSuccessful: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Want to shower?")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Username TextField
                TextField("Enter your username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                // Password SecureField
                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                // Login Button
                Button(action: {
                    handleSignUp()
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Status"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Sign Up")
        }
    }

    // Function to handle login
    private func handleSignUp() {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Both fields are required."
            showAlert = true
            return
        }

        // Simulated login validation
        if username == "user" && password == "password" {
            isLoginSuccessful = true
            errorMessage = "Login successful!"
        } else {
            errorMessage = "Invalid username or password."
        }

        showAlert = true
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
