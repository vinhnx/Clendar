// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Dependencies",
	products: [
		// Products define the executables and libraries produced by a package, and make them visible to other packages.
		.library(
			name: "Dependencies",
			targets: ["Dependencies"]
		)
	],
	dependencies: [
		// Dependencies declare other packages that this package depends on.
		// .package(url: /* package url */, from: "1.0.0"),
		// it's early days here so we haven't tagged a version yet, but will soon
		.package(url: "https://github.com/apple/swift-log.git", .branch("master"))
	],
	targets: [
		// Targets are the basic building blocks of a package. A target can define a module or a test suite.
		// Targets can depend on other targets in this package, and on products in packages which this package depends on.
		.target(
			name: "Dependencies",
			dependencies: ["Logging"]
		),
		.testTarget(
			name: "DependenciesTests",
			dependencies: ["Dependencies"]
		)
	]
)
