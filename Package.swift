//
//  Package.swift
//  SourceIDAuthenticator
//
//  Created by Oko-osi Korede Ibrahim on 06/05/2025.
//

// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "AuthenticatorSDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AuthenticatorSDK",
            targets: ["AuthenticatorSDK"]),
    ],
    targets: [
        .target(
            name: "AuthenticatorSDK",
            path: "Sources"
        )
    ]
)
