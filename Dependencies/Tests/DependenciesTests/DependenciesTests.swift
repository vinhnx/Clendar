@testable import Dependencies
import XCTest

final class DependenciesTests: XCTestCase {
	static var allTests = [
		("testExample", testExample)
	]

	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.
		XCTAssertEqual(Dependencies().text, "Hello, World!")
	}
}
