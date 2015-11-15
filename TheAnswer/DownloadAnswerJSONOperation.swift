import Foundation

let answerURL = NSURL(string: "https://raw.githubusercontent.com/AnthonyEgerton/time-travel-testing/master/TheAnswerTests/SampleAnswer.json")!

private enum ConcurrentState {
    case Ready, Executing, Finished
    func keyPath() -> String {
        switch self {
        case .Ready: return "isReady"
        case .Executing: return "isExecuting"
        case .Finished: return "isFinished"
        }
    }
    func ready() -> Bool { return self == .Ready }
    func executing() -> Bool { return self == .Executing }
    func finished() -> Bool { return self == .Finished }
}

protocol DownloadAnswerJSONOperationDelegate: class {
    func updateAnswerTo(answer: Answer?)
}

class DownloadAnswerJSONOperation: NSOperation {
    private var state = ConcurrentState.Ready {
        willSet {
            willChangeValueForKey(newValue.keyPath())
            willChangeValueForKey(state.keyPath())
        }
        didSet {
            didChangeValueForKey(oldValue.keyPath())
            didChangeValueForKey(state.keyPath())
        }
    }
    
    private let downloader: Downloader
    private weak var delegate: DownloadAnswerJSONOperationDelegate?

    init(downloader: Downloader, delegate: DownloadAnswerJSONOperationDelegate) {
        self.downloader = downloader
        self.delegate = delegate
    }
    
    override var ready: Bool { return super.ready && state.ready() }
    override var executing: Bool { return state.executing() }
    override var finished: Bool { return state.finished() }
    override var asynchronous: Bool { return true }
    
    override func start() {
        guard !cancelled else { state = .Finished; return }
        state = .Executing
        downloader.getDataFromURL(answerURL, completionHandler: getDataCompletionHandler)
    }
    
    private func getDataCompletionHandler(data: NSData?, response: NSURLResponse?, error: NSError?) {
        defer { state = .Finished }
        guard !cancelled else { return }
        let answer = data.flatMap { processJSONData($0) }
        guard !cancelled else { return }
        weak var delegate = self.delegate
        NSOperationQueue.mainQueue().addOperationWithBlock {
            delegate?.updateAnswerTo(answer)
        }
    }
    
    func processJSONData(jsonData: NSData) -> Answer? {
        let jsonObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        let topLevel = jsonObject as? Dictionary<String, String>
        let answerText = topLevel?["Answer"]
        return answerText.map(Answer.init)
    }
}
