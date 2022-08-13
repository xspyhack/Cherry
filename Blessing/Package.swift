// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Blessing",
  platforms: [
    .macOS("13.0"),
    .iOS("16.0"),
    .macCatalyst("16.0")
  ],
  products: [
    .library(
      name: "Blessing",
      targets: ["Blessing"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Blessing",
      dependencies: [],
      path: "Sources"
    ),
  ]
)
