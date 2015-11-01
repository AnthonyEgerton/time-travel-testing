import Foundation

class DeepThought {
    func thinkDeeply() -> Answer {
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