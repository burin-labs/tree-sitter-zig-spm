// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TreeSitterZig",
    products: [.library(name: "TreeSitterZig", targets: ["TreeSitterZig"])],
    targets: [
        .target(
            name: "TreeSitterZig",
            path: "Sources/TreeSitterZig",
            sources: ["src/parser.c"],
            resources: [.copy("queries")],
            publicHeadersPath: "include",
            cSettings: [.headerSearchPath("src")]
        )
    ]
)
