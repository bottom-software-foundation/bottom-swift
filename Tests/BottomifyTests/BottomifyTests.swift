import XCTest
@testable import Bottomify

final class BottomifyTests: XCTestCase {
    func testBottomify() {
        let bottomified = "💖✨✨,,👉👈💖💖,👉👈💖💖🥺,,,👉👈💖💖🥺,,,👉👈💖💖✨,👉👈✨✨✨,,👉👈💖✨✨✨🥺,,👉👈💖💖✨,👉👈💖💖✨,,,,👉👈💖💖🥺,,,👉👈💖💖👉👈✨✨✨,,,👉👈"
        
        let debottomified = "Hello World!"
        let reversed = String(bottomified.reversed())
        
        XCTAssertEqual(debottomified.bottomified(), bottomified)
        XCTAssertEqual(try? bottomified.regressed(), debottomified)
        XCTAssertEqual(String(regressingCharactersIn: bottomified), debottomified)
        
        XCTAssertEqual(String(regressingCharactersIn: reversed), nil)
        XCTAssertEqual(try? reversed.regressed(), nil)
    }

    static var allTests = [
        ("testBottomify", testBottomify),
    ]
}
