import XCTest
@testable import net_mon

class net_monTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(net_mon().text, "Hello, World!")
    }


    static var allTests : [(String, (net_monTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
