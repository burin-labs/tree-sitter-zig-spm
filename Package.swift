// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TreeSitterZig",
    products: [.library(name: "TreeSitterZig", targets: ["TreeSitterZig"])],
    targets: [
        .target(
            name: "TreeSitterZig",
            path: "Sources/TreeSitterZig",
            sources: ["src/parser.c"],
            publicHeadersPath: "include",
            cSettings: [.headerSearchPath("src")]
        )
    ]
)
