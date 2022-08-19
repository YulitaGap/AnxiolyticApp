import UIKit

/**
  Data that will be directed out of the `MeditationsViewController`
  to the  `MeditationsInteractor`.
 */
protocol MeditationsViewControllerOutput {

    /// The `MeditationsViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: MeditationsViewModel)
}

/**
  The `MeditationsViewController` communicates with the `MeditationsInteractor,
  and gets a response back from the `MeditationsPresenter`.
 */
final class MeditationsViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: MeditationsViewControllerOutput!

    // MARK: - Initializers

    /// This will initialise the `MeditationsViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `MeditationsConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        MeditationsConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - MeditationsPresenterOutput

extension MeditationsViewController: MeditationsPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: MeditationsViewModel) {
        // TODO: Update UI
    }
}
