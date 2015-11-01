import XCTest
@testable import TheAnswer

class AnswerServiceTests: XCTestCase {
    func testAnswer() {
        var answer: Answer! = nil
        
        subject.whatIsTheAnswer { answer = $0 }
        
        XCTAssertEqual(String(answer), "42")
    }

    private let subject = AnswerService()
}
