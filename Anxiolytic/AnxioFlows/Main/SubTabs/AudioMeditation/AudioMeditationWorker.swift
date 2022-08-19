import UIKit

/**
 Data that will be directed towards the `AudioMeditationWorker` coming 
 from the `AudioMeditationInteractor`.
 */
protocol AudioMeditationWorkerInput: class {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: AudioMeditationWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `AudioMeditationWorker` to the
 `AudioMeditationInteractor`. This protocol is used to return data
 from the worker.
 */
protocol AudioMeditationWorkerOutput: class {
    
    func didSomeWork()
}

/**
  The `AudioMeditationWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `AudioMeditationInteractor`. It will also handle the success/error response,
  so the `AudioMeditationInteractor` knows how to proceed.
 */
class AudioMeditationWorker: AudioMeditationWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: AudioMeditationWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `AudioMeditationWorker` using
    /// a given `AudioMeditationWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: AudioMeditationWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
