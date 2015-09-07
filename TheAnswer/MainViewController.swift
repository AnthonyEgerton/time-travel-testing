import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var answerLabel: UILabel!
    private let answerService = AnswerService()

    @IBAction func tellMeTheAnswer(sender: UIButton) {
        let answer = answerService.whatIsTheAnswer()
        answerLabel.text = String(answer)
    }
}
