import UIKit

/**
 Data that will be directed towards the `DashboardWorker` coming 
 from the `DashboardInteractor`.
 */
protocol DashboardWorkerInput: class {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: DashboardWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `DashboardWorker` to the
 `DashboardInteractor`. This protocol is used to return data
 from the worker.
 */
protocol DashboardWorkerOutput: class {

    func didSomeWork()
}

/**
  The `DashboardWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `DashboardInteractor`. It will also handle the success/error response,
  so the `DashboardInteractor` knows how to proceed.
 */
class DashboardWorker: DashboardWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: DashboardWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `DashboardWorker` using
    /// a given `DashboardWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: DashboardWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
