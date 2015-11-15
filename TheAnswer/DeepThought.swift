import Foundation

private let morningAnswer = Answer(value: "42")
private let afternoonAnswer = Answer(value: "56")

private func beforeMidday(date: NSDate) -> Bool {
    let midday = middayOfDate(date)
    return date.compare(midday) == .OrderedAscending
}

private func middayOfDate(date: NSDate) -> NSDate {
    return NSCalendar.currentCalendar().dateBySettingHour(12, minute: 0, second: 0, ofDate: date, options: NSCalendarOptions())!
}

class DeepThought: DownloadAnswerJSONOperationDelegate {
    func thinkDeeply(returnAnswer: (Answer) -> Void) {
        if let answer = downloadedAnswer {
            returnAnswer(answer)
        } else {
            let now = date.now()
            async(thinkAboutThis, thinkAboutThat, then: {
                sync_main {
                    if beforeMidday(now) {
                        returnAnswer(morningAnswer)
                    } else {
                        returnAnswer(afternoonAnswer)
                    }
                }
            })
        }
    }
    
    func update() {
        let operation = DownloadAnswerJSONOperation(downloader: downloader, delegate: self)
        operationQueue.addOperation(operation)
    }
    
    func updateAnswerTo(answer: Answer?) {
        downloadedAnswer = answer
    }
    
    var operationCount: Int { return operationQueue.operationCount }
    
    private var downloadedAnswer: Answer? = nil
    private let operationQueue = NSOperationQueue()
    private let date: Date
    private let downloader: Downloader
    init(date: Date = DateProvider(), downloader: Downloader = SessionDownloader()) {
        self.date = date
        self.downloader = downloader
    }
    
    private func thinkAboutThis() {
        sleep(2)
    }
    
    private func thinkAboutThat() {
        sleep(2)
    }
}

protocol Downloader {
    func getDataFromURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void)
}

private class SessionDownloader: Downloader {
    func getDataFromURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url, completionHandler: completionHandler)
        dataTask.resume()
    }
}

protocol Date {
    func now() -> NSDate
}

private class DateProvider: Date {
    func now() -> NSDate {
        return NSDate()
    }
}