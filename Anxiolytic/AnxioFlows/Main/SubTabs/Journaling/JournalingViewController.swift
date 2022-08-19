import UIKit

/**
  Data that will be directed out of the `JournalingViewController`
  to the  `JournalingInteractor`.
 */
protocol JournalingViewControllerOutput {

    /// The `JournalingViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: JournalingViewModel)
}

/**
  The `JournalingViewController` communicates with the `JournalingInteractor,
  and gets a response back from the `JournalingPresenter`.
 */
final class JournalingViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: JournalingViewControllerOutput!

    // MARK: - Initializers

    /// This will initialise the `JournalingViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `JournalingConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        JournalingConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - JournalingPresenterOutput

extension JournalingViewController: JournalingPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: JournalingViewModel) {
        // TODO: Update UI
    }
}
