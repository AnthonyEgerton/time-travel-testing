import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerActivityIndicator: UIActivityIndicatorView!
    private let answerService = AnswerService()
    
    private enum State {
        case Busy, Idle
    }
    
    private var state: State = .Idle {
        didSet {
            switch state {
            case .Busy: answerActivityIndicator.startAnimating()
            case .Idle: answerActivityIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func tellMeTheAnswer(sender: UIButton) {
        let answer = answerService.whatIsTheAnswer()
        answerLabel.text = String(answer)
    }
}
