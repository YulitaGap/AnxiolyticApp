import UIKit

/**
  Data that will be directed out of the `AddAttackViewController`
  to the  `AddAttackInteractor`.
 */
protocol AddAttackViewControllerOutput {

    /// The `AddAttackViewController`'s view finished loading.
    func viewLoaded()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: AddAttackViewModel)
}

/**
  The `AddAttackViewController` communicates with the `AddAttackInteractor,
  and gets a response back from the `AddAttackPresenter`.
 */
final class AddAttackViewController: UIViewController {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: AddAttackViewControllerOutput!

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
        label.text = "How do you feel?"
        label.font = .vmCircularYell36
        label.textColor = .white
        return label
    }()
    private var menuBackgroundView: UIView = {
        let view = UIView(frame: CGRect())
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = Attributes.Colors.truewhite
        return view
    }()
  
    private var menuBackgroundView: UIStackView = {
        let view = UIStackView(frame: CGRect())
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = Attributes.Colors.truewhite
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        return view
    }()

    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Attributes.Colors.accentBlueGrey
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .vmCircularYell24
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = false
        return button
    }()
    // MARK: - Initializers

    /// This will initialise the `AddAttackViewController` using a decoder object.
    /// To configure the relations in VIP, we'll use the default configure
    /// implementation using the `AddAttackConfigurator`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        AddAttackConfigurator.configure(viewController: self)
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
        setUpTableView()
        setUpContinueButton()
        layoutUIElements()
    }

    private func layoutUIElements() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        headerLabel.frame = CGRect(x: 0, y: headerView.frame.height / 4, width: view.frame.size.width, height: headerView.frame.height / 4)
        menuBackgroundView.frame = CGRect(x: 24, y: headerLabel.frame.maxY + 10, width: view.frame.size.width - 48, height: 3 * (view.frame.size.height / 4))
    }

    private func setUpTableView() {
        let tableView = UITableView()
        tableView.register(QuestionCheckUpCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableView.automaticDimension

        menuBackgroundView.addArrangedSubview(tableView)
        tableView.trailingAnchor.constraint(equalTo: menuBackgroundView.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: menuBackgroundView.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: menuBackgroundView.topAnchor, constant: 10).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }

    private func setUpContinueButton() {
        menuBackgroundView.addArrangedSubview(continueButton)
        continueButton.trailingAnchor.constraint(equalTo: menuBackgroundView.trailingAnchor).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: menuBackgroundView.leadingAnchor).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: menuBackgroundView.bottomAnchor, constant: 20).isActive = true
    }
}

// MARK: - AddAttackPresenterOutput

extension AddAttackViewController: AddAttackPresenterOutput {

    // MARK: - Display logic

    func update(with viewModel: AddAttackViewModel) {
        // TODO: Update UI
    }
}

// MARK: - UITableViewDelegate

extension AddAttackViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? QuestionCheckUpCell {
            cell.rowTapped()
        }
    }
}

// MARK: - UITableViewDelegate
extension AddAttackViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return AddAttackViewModel.questionsTableSectionsAmount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddAttackViewModel.questionsTableCellsAmount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(for: indexPath, type: QuestionCheckUpCell.self)
        if !AddAttackViewModel.questionsData.isEmpty {
            cell.configure(question: AddAttackViewModel.questionsData[indexPath.row])
        }
        return cell
    }
}
