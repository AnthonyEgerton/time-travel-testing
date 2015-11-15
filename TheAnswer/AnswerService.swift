import Foundation

class AnswerService {
    private let deepThought = DeepThought()
    
    init() {
        deepThought.update()
    }
    
    func whatIsTheAnswer(returnAnswer: (Answer) -> Void) {
        self.deepThought.thinkDeeply(returnAnswer)
    }
}
