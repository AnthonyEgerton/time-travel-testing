import Foundation

extension Answer: CustomStringConvertible {
    var description: String { return value }
}

struct Answer {
    private let value: String
    init(value: String) {
        self.value = value
    }
}