import XCTest
@testable import TheAnswer

class AnswerServiceTests: XCTestCase {
    func testAnswer() {
        var answer: Answer! = nil
        
        subject.whatIsTheAnswer { answer = $0 }
        delay(4)//💣🕒‼️💥🔥
        
        XCTAssertEqual(String(answer), "42")
    }

    private let subject = AnswerService()
}

private func delay(seconds: NSTimeInterval) {
    insertTimeBombThatWillBiteMeSomeTimeInTheFuture(seconds)
}

private func insertTimeBombThatWillBiteMeSomeTimeInTheFuture(seconds: NSTimeInterval) {
    let date = NSDate(timeIntervalSinceNow: seconds)
    NSRunLoop.mainRunLoop().runUntilDate(date)
}
