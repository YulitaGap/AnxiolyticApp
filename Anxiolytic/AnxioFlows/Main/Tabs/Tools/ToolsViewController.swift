import UIKit

/**
  Data that will be directed out of the `ToolsViewController`
  to the  `ToolsInteractor`.
 */
protocol ToolsViewControllerOutput {

    /// The `ToolsViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: ToolsViewModel)
}

/**
  The `ToolsViewController` communicates with the `ToolsInteractor,
  and gets a response back from the `ToolsPresenter`.
 */
final class ToolsViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: ToolsViewControllerOutput!

    // MARK: - Initializers

    /// This will initialise the `ToolsViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `ToolsConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        ToolsConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - ToolsPresenterOutput

extension ToolsViewController: ToolsPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: ToolsViewModel) {
        view.backgroundColor = viewModel.backgroundColour
    }
}
