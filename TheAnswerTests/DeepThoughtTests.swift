import XCTest
@testable import TheAnswer

class DeepThoughtTests: XCTestCase {
    func testAfterUpdate() {
        downloader.fakeResponses[answerURL] = (sampleData, nil, nil)
        
        subject.update()
        waitForOperations()
        
        let expectAnswer = expectationWithDescription("Answer")
        var answer: Answer! = nil
        subject.thinkDeeply {
            answer = $0
            expectAnswer.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)

        XCTAssertEqual(String(answer), "Life is problems, living is solving problems")
    }
    
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
    
    private let (subject, dateProvider, downloader) = { (DeepThought(date: $0, downloader: $1), $0, $1) }(FakeDateProvider(), FakeDownloader())
    private let morning = date(hour: 9, minute: 0, second: 0)
    private let evening = date(hour: 17, minute: 0, second: 0)
    private lazy var sampleData: NSData = { dataForFileNamed("SampleAnswer", fileExtension: "json") }()
    private var operationCount: Int { return subject.operationCount + NSOperationQueue.mainQueue().operationCount }
    private func waitForOperations() {
        while operationCount > 0 {
            let limitDate = NSDate(timeIntervalSinceNow: 0.1)
            NSRunLoop.mainRunLoop().runUntilDate(limitDate)
        }
    }

}

private class FakeDateProvider: Date {
    var fakeNow: NSDate = NSDate()
    
    func now() -> NSDate {
        return fakeNow
    }
}

private class FakeDownloader: Downloader {
    var fakeResponses = Dictionary<NSURL, (NSData?, NSURLResponse?, NSError?)>()
    func getDataFromURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let response = fakeResponses[url] ?? (nil, nil, nil)
        completionHandler(response)
    }
}

private func date(hour hour: Int, minute: Int, second: Int) -> NSDate {
    let calendar = NSCalendar.currentCalendar()
    return calendar.dateBySettingHour(hour, minute: minute, second: second, ofDate: NSDate(), options: NSCalendarOptions())!
}

private func dataForFileNamed(fileName: String, fileExtension: String) -> NSData {
    let bundle = NSBundle(forClass: DeepThoughtTests.self)
    let url = bundle.URLForResource(fileName, withExtension: fileExtension)!
    let data = NSData(contentsOfURL: url)!
    return data
}
