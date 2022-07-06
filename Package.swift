// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Web3Swift",
  platforms: [.macOS(.v12), .iOS(.v15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Web3Swift",
      targets: ["Web3Swift"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
    .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.5.1"),
    .package(url: "https://github.com/GigaBitcoin/secp256k1.swift", from: "0.7.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Web3Swift",
      dependencies: [
        "BigInt",
        "CryptoSwift",
        .product(name: "secp256k1", package: "secp256k1.swift")
      ], resources: [
        .process("BIP/39/Resources")
      ]),
    .testTarget(
      name: "Web3SwiftTests",
      dependencies: ["Web3Swift"])
  ]
)
