import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tellMeButton: UIButton!
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
            answerLabel.hidden = answerActivityIndicator.isAnimating()
            tellMeButton.enabled = !answerActivityIndicator.isAnimating()
        }
    }
    
    @IBAction func tellMeTheAnswer(sender: UIButton) {
        state = .Busy
        answerService.whatIsTheAnswer { (answer) in
            self.state = .Idle
            self.answerLabel.text = String(answer)
        }
    }
}
