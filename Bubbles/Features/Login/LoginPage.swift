//
//  SignUpPage.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//
import SwiftUI
import Firebase

struct LoginPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToMain: Bool = false
    @State private var navigateToSignUp: Bool = false // State for navigating to SignUpPage

    var body: some View {
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

            Button(action: {
                navigateToSignUp = true // Navigate to SignUpPage
            }) {
                Text("Don't have an account? Sign Up")
                    .foregroundColor(.blue)
                    .padding(.top)
            }
        }
        .padding()
        .navigationTitle("Login")
        .background(
            // Programmatic navigation using state variables
            Group {
                if navigateToMain {
                    ContentView() // Navigate to main content
                } else if navigateToSignUp {
                    SignUpPage() // Navigate to SignUpPage
                }
            }
        )
    }

    private func handleLogin() {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Both fields are required."
            showAlert = true
            return
        }

        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if let error = error {
                self.errorMessage = "Error: \(error.localizedDescription)"
                self.isLoginSuccessful = false
            } else {
                self.isLoginSuccessful = true
                self.errorMessage = "Login successful!"
                self.navigateToMain = true
            }
            self.showAlert = true
        }
    }
}
