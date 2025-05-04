//
//  Authenticator.swift
//  SourceIDAuthenticator
//
//  Created by Oko-osi Korede Ibrahim on 04/05/2025.
//

import UIKit

public class AuthenticatorController: UIViewController {
    // MARK: - UI Components
     let emailTextField = UITextField()
     let passwordTextField = UITextField()
     let usernameTextField = UITextField()
     let firstNameTextField = UITextField()
     let lastNameTextField = UITextField()
     let submitButton = UIButton(type: .system)

    // MARK: - Public Properties
    public var config: AuthConfig = AuthConfig() {
        didSet {
            applyConfig()
        }
    }
    
    // MARK: - ViewModel
    let viewModel: AuthenticatorViewModel = AuthenticatorViewModel()

    // MARK: - Lifecycle Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyConfig()
    }

    private func setupUI() {
        view.backgroundColor = config.backgroundColor

        let stackView = UIStackView(arrangedSubviews: [
            emailTextField, usernameTextField, passwordTextField,
            firstNameTextField, lastNameTextField, submitButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress

        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect

        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true

        firstNameTextField.placeholder = "First Name"
        firstNameTextField.borderStyle = .roundedRect

        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.borderStyle = .roundedRect

        submitButton.setTitle(config.submitButtonText, for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
    }

    private func applyConfig() {
        view.backgroundColor = config.backgroundColor

        emailTextField.font = config.font
        emailTextField.textColor = config.textColor

        usernameTextField.font = config.font
        usernameTextField.textColor = config.textColor
        usernameTextField.isHidden = config.isUsernameFieldHidden

        passwordTextField.font = config.font
        passwordTextField.textColor = config.textColor

        firstNameTextField.font = config.font
        firstNameTextField.textColor = config.textColor
        firstNameTextField.isHidden = config.isFirstNameFieldHidden

        lastNameTextField.font = config.font
        lastNameTextField.textColor = config.textColor
        lastNameTextField.isHidden = config.isLastNameFieldHidden

        submitButton.backgroundColor = config.primaryColor
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitle(config.submitButtonText, for: .normal)
    }

    @objc func submitAction() {
        guard let email = emailTextField.text, viewModel.isValidEmail(email),
              let password = passwordTextField.text, viewModel.isValidPassword(password),
              let username = usernameTextField.text, viewModel.isValidUsername(username) || config.isUsernameFieldHidden,
              let firstName = firstNameTextField.text, !firstName.isEmpty || config.isFirstNameFieldHidden,
              let lastName = lastNameTextField.text, !lastName.isEmpty || config.isLastNameFieldHidden else {
            showErrorAlert()
            return
        }

        let userDetails: [String: String] = [
            "email": email,
            "password": password,
            "username": username,
            "firstName": firstName,
            "lastName": lastName
        ].compactMapValues { $0.isEmpty ? nil : $0 }

        viewModel.storeCredentials(email: email, password: password)

        viewModel.onCompletion?(userDetails)
        viewModel.userDetailsPublisher.send(userDetails)
        dismiss(animated: true)
    }

    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: config.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
