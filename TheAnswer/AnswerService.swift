import Foundation

class AnswerService {
    private let deepThought = DeepThought()
    
    func whatIsTheAnswer(returnAnswer: (Answer) -> Void) {
        async {
            let answer = self.deepThought.thinkDeeply()
            sync_main { returnAnswer(answer) }
        }
    }
}
