import Foundation

class AnswerService {
    private let deepThought = DeepThought()
    
    func whatIsTheAnswer(returnAnswer: (Answer) -> Void) {
        self.deepThought.thinkDeeply(returnAnswer)
    }
}
