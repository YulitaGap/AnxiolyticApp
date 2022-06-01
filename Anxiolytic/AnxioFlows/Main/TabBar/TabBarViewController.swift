import UIKit
import FirebaseAuth
/**
  Data that will be directed out of the `TabBarViewController`
  to the  `TabBarInteractor`.
 */
protocol TabBarViewControllerOutput {

    /// The `TabBarViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: TabBarViewModel)
}

/**
  The `TabBarViewController` communicates with the `TabBarInteractor,
  and gets a response back from the `TabBarPresenter`.
 */
final class TabBarViewController: UITabBarController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: TabBarViewControllerOutput!

    var user: User?

    // MARK: - Initializers

    /// This will initialise the `TabBarViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `TabBarConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        TabBarConfigurator.configure(viewController: self)
    }

    convenience init() {
        self.init()
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - TabBarPresenterOutput

extension TabBarViewController: TabBarPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: TabBarViewModel) {
        // TODO: Update UI
    }
}
