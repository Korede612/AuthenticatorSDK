//
//  AuthenticatorViewModel.swift
//  SourceIDAuthenticator
//
//  Created by Oko-osi Korede Ibrahim on 04/05/2025.
//

import Combine
import Security

class AuthenticatorViewModel {
    public var onCompletion: (([String: String]) -> Void)?

    // MARK: - Combine Subject
    public var userDetailsPublisher = PassthroughSubject<[String: String], Never>()
    
    init() {
        
    }
    
    // MARK: - Validation Methods
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[A-Za-z0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", usernameRegex).evaluate(with: username)
    }
    
    // MARK: - Keychain Storage
    func storeCredentials(email: String, password: String) {
        let credentials = ["email": email, "password": password]
        if let data = try? JSONSerialization.data(withJSONObject: credentials) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: "com.example.authsdk.credentials",
                kSecValueData as String: data
            ]
            SecItemAdd(query as CFDictionary, nil)
        }
    }
}
    
