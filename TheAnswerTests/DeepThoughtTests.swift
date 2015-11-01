import XCTest
@testable import TheAnswer

class DeepThoughtTests: XCTestCase {
    func testAnswer() {
        let answer = subject.thinkDeeply()
        
        XCTAssertEqual(String(answer), "42")
    }

    private let subject = DeepThought()
}