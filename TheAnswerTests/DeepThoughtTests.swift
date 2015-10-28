import XCTest
@testable import TheAnswer

class DeepThoughtTests: XCTestCase {
    func testMorning() {
        dateProvider.fakeNow = morning
        let expectAnswer = expectationWithDescription("Answer")
        var answer: Answer! = nil
        
        subject.thinkDeeply {
            answer = $0
            expectAnswer.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)

        XCTAssertEqual(String(answer), "42")
    }
    
    func testEvening() {
        dateProvider.fakeNow = evening
        let expectAnswer = expectationWithDescription("Answer")
        var answer: Answer! = nil
        
        subject.thinkDeeply {
            answer = $0
            expectAnswer.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
        
        XCTAssertEqual(String(answer), "56")
    }
    
    private let (subject, dateProvider) = { (DeepThought(date: $0), $0) }(FakeDateProvider())
    private let morning = date(hour: 9, minute: 0, second: 0)
    private let evening = date(hour: 17, minute: 0, second: 0)
}

private class FakeDateProvider: Date {
    var fakeNow: NSDate = NSDate()
    
    func now() -> NSDate {
        return fakeNow
    }
}

private func date(hour hour: Int, minute: Int, second: Int) -> NSDate {
    let calendar = NSCalendar.currentCalendar()
    return calendar.dateBySettingHour(hour, minute: minute, second: second, ofDate: NSDate(), options: NSCalendarOptions())!
}
