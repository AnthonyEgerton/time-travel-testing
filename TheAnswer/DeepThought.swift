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

class DeepThought {
    func thinkDeeply(returnAnswer: (Answer) -> Void) {
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
    
    private let date: Date
    init(date: Date = DateProvider()) {
        self.date = date
    }
    
    private func thinkAboutThis() {
        sleep(2)
    }
    
    private func thinkAboutThat() {
        sleep(2)
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