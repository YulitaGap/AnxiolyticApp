import UIKit

/**
  Data that will be directed out of the `DashboardViewController`
  to the  `DashboardInteractor`.
 */
protocol DashboardViewControllerOutput {

    /// The `DashboardViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: DashboardViewModel)
}

/**
  The `DashboardViewController` communicates with the `DashboardInteractor,
  and gets a response back from the `DashboardPresenter`.
 */
final class DashboardViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: DashboardViewControllerOutput!

    // MARK: - Initializers

    /// This will initialise the `DashboardViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `DashboardConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        DashboardConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - DashboardPresenterOutput

extension DashboardViewController: DashboardPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: DashboardViewModel) {
        // TODO: Update UI
    }
}
