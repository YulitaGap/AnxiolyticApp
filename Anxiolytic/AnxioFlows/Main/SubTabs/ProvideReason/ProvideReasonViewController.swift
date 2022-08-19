import UIKit

/**
  Data that will be directed out of the `ProvideReasonViewController`
  to the  `ProvideReasonInteractor`.
 */
protocol ProvideReasonViewControllerOutput {

    /// The `ProvideReasonViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: ProvideReasonViewModel)
}

/**
  The `ProvideReasonViewController` communicates with the `ProvideReasonInteractor,
  and gets a response back from the `ProvideReasonPresenter`.
 */
final class ProvideReasonViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: ProvideReasonViewControllerOutput!

    // MARK: - Initializers

    /// This will initialise the `ProvideReasonViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `ProvideReasonConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        ProvideReasonConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - ProvideReasonPresenterOutput

extension ProvideReasonViewController: ProvideReasonPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: ProvideReasonViewModel) {
        // TODO: Update UI
    }
}
