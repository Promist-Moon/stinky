//
//  SignUpPage.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//
import SwiftUI

struct LoginPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToMain: Bool = false

    var body: some View {
        NavigationStack {  // Changed from NavigationView to NavigationStack
            VStack(spacing: 20) {
                Text("Showering now?")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Enter your username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                SecureField("Enter your password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Button(action: {
                    handleLogin()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Status"),
                          message: Text(errorMessage),
                          dismissButton: .default(Text("OK")) {
                              if isLoginSuccessful {
                                  navigateToMain = true
                              }
                          })
                }
                
                // Using navigationDestination instead of NavigationLink
                .navigationDestination(isPresented: $navigateToMain) {
                    ContentView()
                }
                
                // Modern NavigationLink for SignUp
                NavigationLink(value: "signup") {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                        .padding(.top)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .navigationDestination(for: String.self) { route in
                if route == "signup" {
                    SignUpPage()
                }
            }
        }
    }

    private func handleLogin() {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Both fields are required."
            showAlert = true
            return
        }

        if username == "user" && password == "password" {
            isLoginSuccessful = true
            errorMessage = "Login successful!"
        } else {
            isLoginSuccessful = false
            errorMessage = "Invalid username or password."
        }

        showAlert = true
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
