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

    func logOutButtonTapped()
}

/**
  The `SettingsViewController` communicates with the `SettingsInteractor,
  and gets a response back from the `SettingsPresenter`.
 */
final class SettingsViewController: UIViewController {

    private var headerView: UIView = {
        let view = UIView(frame: CGRect())
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = Attributes.Colors.blueGrey
        return view
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Settings"
        label.font = .vmCircularYell50
        label.textColor = .white
        return label
    }()

    private var menuBackgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "settings.png")
        view.scalesLargeContentImage = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = Attributes.Colors.truewhite
        return view
    }()

    private let registerButton: UIButton = {
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Attributes.Colors.accentBlueGrey
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .vmCircularYell24
        button.setTitle("Log out", for: .normal)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = false
        return button
    }()

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

        configureAppearance()
        output.viewLoaded()
    }

    private func configureAppearance() {
        view.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(headerLabel)
        view.addSubview(menuBackgroundView)
        view.addSubview(registerButton)

        registerButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        view.addSubview(logOutButton)

        logOutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        layoutUIElements()
    }

    private func layoutUIElements() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        headerLabel.frame = CGRect(x: 0, y: headerView.frame.height / 4, width: view.frame.size.width, height: headerView.frame.height / 4)
        menuBackgroundView.frame = CGRect(x: 28, y: headerLabel.frame.maxY + 10, width: view.frame.size.width - 56, height: view.frame.size.height - 250)
        registerButton.frame = CGRect(
        logOutButton.frame = CGRect(
            x: menuBackgroundView.frame.minX + 20,
            y: 450,
            width: menuBackgroundView.frame.width - 40,
            height: 50
        )
    }

    @objc private func didTapLogOutButton() {
        output.logOutButtonTapped()
    }
}

// MARK: - SettingsPresenterOutput

extension SettingsViewController: SettingsPresenterOutput {
    // MARK: - Display logic

    func update(with viewModel: SettingsViewModel) {
        view.backgroundColor = viewModel.backgroundColour
    }

    func showAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
}
