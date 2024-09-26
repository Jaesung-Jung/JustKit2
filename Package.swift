// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "JustKit",
  platforms: [
    .iOS(.v16),
    .macCatalyst(.v16)
  ],
  products: [
    .library(name: "JustFoundation", targets: ["JustFoundation"]),
    .library(name: "JustUI", targets: ["JustUI"]),
  ],
  targets: [
    .target(
      name: "JustFoundation",
      path: "Sources/Foundation"
    ),
    .target(
      name: "JustUI",
      dependencies: [
        "JustFoundation"
      ],
      path: "Sources/UI"
    ),
    .testTarget(
      name: "JustKitTests",
      dependencies: ["JustFoundation", "JustUI"]
    )
  ]
)
