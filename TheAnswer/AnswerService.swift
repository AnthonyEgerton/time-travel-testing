import Foundation

class AnswerService {
    func whatIsTheAnswer() -> Answer {
        return thinkDeeply()
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
