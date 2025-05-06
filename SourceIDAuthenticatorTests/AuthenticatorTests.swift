//
//  AuthenticatorTests.swift
//  SourceIDAuthenticator
//
//  Created by Oko-osi Korede Ibrahim on 04/05/2025.
//

import XCTest
@testable import SourceIDAuthenticator

class AuthViewControllerTests: XCTestCase {

    var viewController: AuthenticatorController!

    override func setUp() {
        super.setUp()
        viewController = AuthenticatorController()
        viewController.loadViewIfNeeded()
    }

    func testSubmitActionWithValidInputs() {
        viewController.emailTextField.text = "test@example.com"
        viewController.passwordTextField.text = "Password123"
        viewController.usernameTextField.text = "username123"
        viewController.firstNameTextField.text = "John"
        viewController.lastNameTextField.text = "Doe"

        var capturedData: [String: String]?
        viewController.viewModel.onCompletion = { data in
            capturedData = data
        }

        viewController.submitAction()

        XCTAssertNotNil(capturedData)
        XCTAssertEqual(capturedData?["email"], "test@example.com")
        XCTAssertEqual(capturedData?["password"], "Password123")
        XCTAssertEqual(capturedData?["username"], "username123")
        XCTAssertEqual(capturedData?["firstName"], "John")
        XCTAssertEqual(capturedData?["lastName"], "Doe")
    }

    func testSubmitActionWithInvalidInputs() {
        viewController.emailTextField.text = "invalid-email"
        viewController.passwordTextField.text = "short"
        viewController.usernameTextField.text = "user name"
        viewController.firstNameTextField.text = ""
        viewController.lastNameTextField.text = ""

        var capturedData: [String: String]?
        viewController.viewModel.onCompletion = { data in
            capturedData = data
        }

        viewController.submitAction()

        XCTAssertNil(capturedData)
    }
}
