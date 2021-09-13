// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "BlogPostsByElserafy",
    products: [
        .executable(
            name: "BlogPostsByElserafy",
            targets: ["BlogPostsByElserafy"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "BlogPostsByElserafy",
            dependencies: ["Publish"]
        )
    ]
)