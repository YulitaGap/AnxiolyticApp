import UIKit

/**
  Data that will be directed out of the `WelcomeViewController`
  to the  `WelcomeInteractor`.
 */
protocol WelcomeViewControllerOutput {

    /// The `WelcomeViewController`'s view finished loading.
    func viewLoaded()

    func logInButtonTapped()

    func registerButtonTapped()

    func checkIfLogged()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: WelcomeViewModel)
}

/**
  The `WelcomeViewController` communicates with the `WelcomeInteractor,
  and gets a response back from the `WelcomePresenter`.
 */
final class WelcomeViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: WelcomeViewControllerOutput!

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "login_background.png")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Anxiolytic"
        label.font = .vmCircularYell50
        label.textColor = Attributes.Colors.accentBlueGrey
        return label
    }()

    private let subheaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Welcome to the app which will be your new kind of anxiolytic."
        label.font = .vmCircularYell16
        label.textColor = Attributes.Colors.accentBlueGrey
        return label
    }()

    private let logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Attributes.Colors.blueGrey
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .vmCircularYell24
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = false
        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Attributes.Colors.accentBlueGrey
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .vmCircularYell24
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = false
        return button
    }()

    // MARK: - Initializers

    /// This will initialise the `WelcomeViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `WelcomeConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        WelcomeConfigurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output.checkIfLogged()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        output.viewLoaded()
    }

    private func setUpViews() {

        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.addSubview(headerLabel)
        view.addSubview(subheaderLabel)
        view.addSubview(logInButton)
        view.addSubview(registerButton)

        logInButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutUIElements()
    }

    private func layoutUIElements() {
        headerLabel.frame = CGRect(x: 0, y: view.frame.size.height / 2, width: view.frame.size.width, height: 80)

        subheaderLabel.frame = CGRect(
            x: 20,
            y: headerLabel.frame.origin.y + headerLabel.frame.size.height + 10,
            width: view.frame.size.width - 40,
            height: 50
        )
        registerButton.frame = CGRect(
            x: 20,
            y: subheaderLabel.frame.origin.y + subheaderLabel.frame.size.height + 60,
            width: view.frame.size.width - 40,
            height: 60
        )

        logInButton.frame = CGRect(
            x: 20,
            y: registerButton.frame.origin.y + registerButton.frame.size.height + 20,
            width: view.frame.size.width - 40,
            height: 60
        )
    }

    @objc private func didTapLogInButton() {
        output.logInButtonTapped()
    }

    @objc private func didTapRegisterButton() {
        output.registerButtonTapped()
    }
}

// MARK: - WelcomePresenterOutput

extension WelcomeViewController: WelcomePresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: WelcomeViewModel) {
        // TODO: Update UI
    }
}
