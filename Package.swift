import PackageDescription

let package = Package(
    name: "net-mon",
    targets: [
      Target(name: "c"),
      Target(name: "swift-exec", dependencies: ["c"])
    ]
)
