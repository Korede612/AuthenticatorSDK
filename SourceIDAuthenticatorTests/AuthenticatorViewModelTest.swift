//
//  AuthenticatorViewModelTest.swift
//  SourceIDAuthenticator
//
//  Created by Oko-osi Korede Ibrahim on 04/05/2025.
//

import XCTest
@testable import SourceIDAuthenticator

class AuthenticatorViewModelTest: XCTestCase {

    var viewModel: AuthenticatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = AuthenticatorViewModel()
    }

    func testEmailValidation() {
        XCTAssertTrue(viewModel.isValidEmail("test@example.com"))
        XCTAssertFalse(viewModel.isValidEmail("invalid-email"))
    }

    func testPasswordValidation() {
        XCTAssertTrue(viewModel.isValidPassword("Password123"))
        XCTAssertFalse(viewModel.isValidPassword("short"))
        XCTAssertFalse(viewModel.isValidPassword("n0specialchars"))
    }

    func testUsernameValidation() {
        XCTAssertTrue(viewModel.isValidUsername("username123"))
        XCTAssertFalse(viewModel.isValidUsername("user name"))
        XCTAssertFalse(viewModel.isValidUsername("username!@#"))
    }
}
