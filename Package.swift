import PackageDescription

let package = Package(
    name: "net-mon",
    targets: [
      Target(name: "objc"),
      Target(name: "swift-exec", dependencies: ["objc"])
    ]
)
