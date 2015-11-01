import Foundation

class AnswerService {
    func whatIsTheAnswer(returnAnswer: (Answer) -> Void) {
        async {
            let answer = self.thinkDeeply()
            sync_main { returnAnswer(answer) }
        }
    }
    
    private func thinkDeeply() -> Answer {
        thinkAboutThis()
        thinkAboutThat()
        return Answer()
    }
    
    private func thinkAboutThis() {
        sleep(2)
    }
    
    private func thinkAboutThat() {
        sleep(2)
    }
}
