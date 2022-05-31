import UIKit

/**
 Data that will be directed towards the `ToolsWorker` coming 
 from the `ToolsInteractor`.
 */
protocol ToolsWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: ToolsWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `ToolsWorker` to the
 `ToolsInteractor`. This protocol is used to return data
 from the worker.
 */
protocol ToolsWorkerOutput: AnyObject {

    func didSomeWork()
}

/**
  The `ToolsWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `ToolsInteractor`. It will also handle the success/error response,
  so the `ToolsInteractor` knows how to proceed.
 */
class ToolsWorker: ToolsWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: ToolsWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `ToolsWorker` using
    /// a given `ToolsWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: ToolsWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
