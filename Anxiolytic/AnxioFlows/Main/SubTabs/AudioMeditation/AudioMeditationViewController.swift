import UIKit

/**
  Data that will be directed out of the `AudioMeditationViewController`
  to the  `AudioMeditationInteractor`.
 */
protocol AudioMeditationViewControllerOutput {

    /// The `AudioMeditationViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: AudioMeditationViewModel)
}

/**
  The `AudioMeditationViewController` communicates with the `AudioMeditationInteractor,
  and gets a response back from the `AudioMeditationPresenter`.
 */
final class AudioMeditationViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: AudioMeditationViewControllerOutput!

    // MARK: - Initializers

    /// This will initialise the `AudioMeditationViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `AudioMeditationConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        AudioMeditationConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - AudioMeditationPresenterOutput

extension AudioMeditationViewController: AudioMeditationPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: AudioMeditationViewModel) {
        // TODO: Update UI
    }
}
