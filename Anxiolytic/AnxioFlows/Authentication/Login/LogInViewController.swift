import UIKit

/**
  Data that will be directed out of the `LogInViewController`
  to the  `LogInInteractor`.
 */
protocol LogInViewControllerOutput {

    /// The `LogInViewController`'s view finished loading.
    func viewLoaded()

    func logInButtonTapped(email: String, password: String)

    func noCredentialsEntered()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: LogInViewModel)
}

/**
  The `LogInViewController` communicates with the `LogInInteractor,
  and gets a response back from the `LogInPresenter`.
 */
final class LogInViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: LogInViewControllerOutput!

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .vmCircularYell50
        label.textColor = .white
        return label
    }()

    private let emailTextField: AnxioTextField = {
        let emailTextField = AnxioTextField()
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.clipsToBounds = false
        emailTextField.textColor = .white
        emailTextField.font = UIFont.vmCircularYell16
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email adress",
            attributes: [NSAttributedString.Key.foregroundColor: Attributes.Colors.accentBlueGrey, NSAttributedString.Key.font: UIFont.vmCircularYell16]
        )

        return emailTextField
    }()

    private let passwordTextField: AnxioTextField = {
        let passwordTextField = AnxioTextField()
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.clipsToBounds = false
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Email adress",
            attributes: [NSAttributedString.Key.foregroundColor: Attributes.Colors.accentBlueGrey, NSAttributedString.Key.font: UIFont.vmCircularYell16]
        )
        passwordTextField.isSecureTextEntry = true

        return passwordTextField
    }()

    private let logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(Attributes.Colors.accentBlueGrey, for: .normal)
        button.titleLabel?.font = .vmCircularYell24
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10.0 // self.frame.size.height/2
        button.clipsToBounds = false
        return button
    }()

    // MARK: - Initializers

    /// This will initialise the `LogInViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `LogInConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        LogInConfigurator.configure(viewController: self)
    }

    convenience init() {
        self.init()
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        output.viewLoaded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutUIElements()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        emailTextField.becomeFirstResponder()
    }

    @objc private func didTapButton() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                  self.output.noCredentialsEntered()
                  return
              }

        self.output.logInButtonTapped(email: email, password: password)

    }

    private func setUpViews() {
        view.addSubview(headerLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        logInButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    private func layoutUIElements() {

        headerLabel.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)

        emailTextField.frame = CGRect(
            x: 20,
            y: headerLabel.frame.origin.y + headerLabel.frame.size.height + 10,
            width: view.frame.size.width - 40,
            height: 50
        )

        passwordTextField.frame = CGRect(
            x: 20,
            y: emailTextField.frame.origin.y + emailTextField.frame.size.height + 10,
            width: view.frame.size.width - 40,
            height: 50
        )

        logInButton.frame = CGRect(
            x: 20,
            y: passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 20,
            width: view.frame.size.width - 40,
            height: 60
        )
    }
}

// MARK: - LogInPresenterOutput

extension LogInViewController: LogInPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: LogInViewModel) {
        // TODO: Update UI
    }

    func showAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
}
