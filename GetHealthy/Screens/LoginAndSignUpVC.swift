//
//  LoginAndSignUpVC.swift
//  GetHealthy
//
//  Created by Archana Kumari on 15/09/25.
//

import UIKit

// MARK: - LoginViewController

class LoginViewController: UIViewController {
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Don't have an account? Sign up", for: .normal)
        btn.setTitleColor(.systemGray, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Login"
        setupSubviews()
    }
    
    @objc func showSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Input Error", message: "Please enter both email and password.")
            return
        }
        
        // Add authentication logic here (e.g., API call)
        print("Logging in with email: \(email) and password: \(password)")
        let healthVC = HealthDataViewController()
        navigationController?.pushViewController(healthVC, animated: true)
    }
    
    private func setupSubviews() {
        [emailTextField, passwordTextField, loginButton, signUpButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        signUpButton.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alertVC, animated: true)
    }
}

// MARK: - SignUpViewController

class SignUpViewController: UIViewController {
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Confirm Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.addTarget(SignUpViewController.self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Sign Up"
        setupSubviews()
    }
    
    private func setupSubviews() {
        [emailTextField, passwordTextField, confirmPasswordTextField, signUpButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 24),
            signUpButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func handleSignUp() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(title: "Input Error", message: "Please fill in all fields.")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(title: "Input Error", message: "Passwords do not match.")
            return
        }
        
        // Add registration logic here (e.g., API call)
        print("Signing up with email: \(email) and password: \(password)")
        showAlert(title: "Success", message: "Registered successfully. Please log in.") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okay", style: .default) { _ in
            completion?()
        })
        present(alertVC, animated: true)
    }
}
