//
//  AuthConfig.swift
//  SourceIDAuthenticator
//
//  Created by Oko-osi Korede Ibrahim on 04/05/2025.
//

import UIKit

public struct AuthConfig {
    public var primaryColor: UIColor = .systemBlue
    public var backgroundColor: UIColor = .white
    public var textColor: UIColor = .black
    public var font: UIFont = UIFont.systemFont(ofSize: 16)
    public var submitButtonText: String = "Submit"
    public var errorMessage: String = "Invalid input. Please check your details and try again."
    public var isUsernameFieldHidden: Bool = false
    public var isFirstNameFieldHidden: Bool = false
    public var isLastNameFieldHidden: Bool = false

    public init() {}
}
