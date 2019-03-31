import XCTest
@testable import Dependencies

final class DependenciesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Dependencies().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
