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
        label.text = "Tools"
        label.font = .vmCircularYell50
        label.textColor = .white
        return label
    }()

    private var menuBackgroundView: UIView = {
        let view = UIImageView()
        view.image = UIImage(named: "tools.png")
        view.scalesLargeContentImage = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = Attributes.Colors.truewhite
        return view
    }()

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

        configureAppearance()
        output.viewLoaded()
    }

    private func configureAppearance() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(headerLabel)
        view.addSubview(menuBackgroundView)
        layoutUIElements()

    }

    private func layoutUIElements() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        headerLabel.frame = CGRect(x: 0, y: headerView.frame.height / 4, width: view.frame.size.width, height: headerView.frame.height / 4)
        menuBackgroundView.frame = CGRect(x: 28, y: headerLabel.frame.maxY + 10, width: view.frame.size.width - 56, height: view.frame.size.height - 250)
    }
}

// MARK: - ToolsPresenterOutput

extension ToolsViewController: ToolsPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: ToolsViewModel) {
    }
}
