import XCTest
@testable import TheAnswer

class AnswerServiceTests: XCTestCase {
    func testAnswer() {
        let answer = subject.whatIsTheAnswer()
        
        XCTAssertEqual(String(answer), "42")
    }

    private let subject = AnswerService()
}
