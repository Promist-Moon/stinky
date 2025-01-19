//
//  FriendsViewController.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//
import SwiftUI
import UIKit

class AddFriendViewController: UIViewController {

    private var userIDTextField: UITextField!
    private var database: [String: [String]] = [:] // Simulated database with userID as key and friend list as value

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = "Add Friend"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        userIDTextField = UITextField()
        userIDTextField.placeholder = "Friend's User ID"
        userIDTextField.borderStyle = .roundedRect
        userIDTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userIDTextField)

        let addButton = UIButton(type: .system)
        addButton.setTitle("Add Friend", for: .normal)
        addButton.addTarget(self, action: #selector(addFriendTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)

        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            userIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userIDTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            userIDTextField.widthAnchor.constraint(equalToConstant: 300),

            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: userIDTextField.bottomAnchor, constant: 20)
        ])
    }

    @objc private func addFriendTapped() {
        guard let userID = userIDTextField.text, !userID.isEmpty else {
            print("User ID is required")
            return
        }

        let currentUserID = "current_user" // Replace with actual current user ID

        if database[currentUserID] == nil {
            database[currentUserID] = []
        }

        database[currentUserID]?.append(userID)
        print("Friend added: \(userID)")
        print("Updated friend list: \(database[currentUserID] ?? [])")
    }
}

// AppDelegate or SceneDelegate setup to launch LoginViewController
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: LoginViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
