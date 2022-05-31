import UIKit

/**
  Data that will be directed out of the `SettingsViewController`
  to the  `SettingsInteractor`.
 */
protocol SettingsViewControllerOutput {

    /// The `SettingsViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: SettingsViewModel)
}

/**
  The `SettingsViewController` communicates with the `SettingsInteractor,
  and gets a response back from the `SettingsPresenter`.
 */
final class SettingsViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: SettingsViewControllerOutput!

    // MARK: - Initializers

    /// This will initialise the `SettingsViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `SettingsConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        SettingsConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewLoaded()
    }
}

// MARK: - SettingsPresenterOutput

extension SettingsViewController: SettingsPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: SettingsViewModel) {
        view.backgroundColor = viewModel.backgroundColour
    }
}
