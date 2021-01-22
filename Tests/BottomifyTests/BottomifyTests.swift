import XCTest
@testable import Bottomify

final class BottomifyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let helloWorld = "💖✨✨,,👉👈💖💖,👉👈💖💖🥺,,,👉👈💖💖🥺,,,👉👈💖💖✨,👉👈✨✨✨,,👉👈💖✨✨✨🥺,,👉👈💖💖✨,👉👈💖💖✨,,,,👉👈💖💖🥺,,,👉👈💖💖👉👈✨✨✨,,,👉👈"
        XCTAssertEqual("Hello World!".bottomified(), helloWorld)
        XCTAssertEqual(try helloWorld.regressed(), "Hello World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
