import UIKit

/**
 Data that will be directed towards the `TabBarWorker` coming 
 from the `TabBarInteractor`.
 */
protocol TabBarWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: TabBarWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `TabBarWorker` to the
 `TabBarInteractor`. This protocol is used to return data
 from the worker.
 */
protocol TabBarWorkerOutput: AnyObject {

    func didSomeWork()
}

/**
  The `TabBarWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `TabBarInteractor`. It will also handle the success/error response,
  so the `TabBarInteractor` knows how to proceed.
 */
class TabBarWorker: TabBarWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: TabBarWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `TabBarWorker` using
    /// a given `TabBarWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: TabBarWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
