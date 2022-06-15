import UIKit
import FLCharts

/**
  Data that will be directed out of the `DashboardViewController`
  to the  `DashboardInteractor`.
 */
protocol DashboardViewControllerOutput {

    /// The `DashboardViewController`'s view finished loading.
    func viewLoaded()

    func viewWillAppear()

    /// The user's input changed and therefore the model
    /// needs an update (e.g. for validation).
    ///
    /// - Parameter viewModel: The model representing the
    ///                    current state of the userinterface.
    func viewContentUpdated(with viewModel: DashboardViewModel)

    func addButtonTapped()
}

/**
  The `DashboardViewController` communicates with the `DashboardInteractor,
  and gets a response back from the `DashboardPresenter`.
 */
final class DashboardViewController: UIViewController {
    var output: DashboardViewControllerOutput!

    private lazy var calendarView = CalendarView()

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
        label.text = "Anxiolytic"
        label.font = .vmCircularYell50
        label.textColor = Attributes.Colors.truewhite
        return label
    }()

    private var menuBackgroundView: UIStackView = {
        let view = UIStackView(frame: CGRect())
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = Attributes.Colors.truewhite
        view.axis = .vertical
        view.spacing = 15
        return view
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 15
        return stackView
    }()

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

    override func viewWillAppear(_ animated: Bool) {
        output.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        output.viewLoaded()
    }

    func setUpView() {
        setUpHeader()
        setUpTrackerView()
        setUpBarChartView()
        setUpCalendarView()
    }

    private func setUpHeader() {
        view.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(headerLabel)
        view.addSubview(menuBackgroundView)
        layoutUIElements()
    }

    private func layoutUIElements() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3)
        headerLabel.frame = CGRect(x: 0, y: headerView.frame.height / 4, width: view.frame.size.width, height: headerView.frame.height / 4)
        menuBackgroundView.frame = CGRect(x: 24, y: headerLabel.frame.maxY + 10, width: view.frame.size.width - 48, height: view.frame.size.height - 240)
    }

    private func setUpTrackerView() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "trackerView.png")
        menuBackgroundView.addArrangedSubview(imageView)
        imageView.topAnchor.constraint(equalTo: menuBackgroundView.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: menuBackgroundView.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: menuBackgroundView.trailingAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalTo: menuBackgroundView.widthAnchor, constant: -40).isActive = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.proceedToAttackTracking))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true

        let trackerView = TrackerView()
        trackerView.delegate = self
        menuBackgroundView.addArrangedSubview(trackerView)

        trackerView.topAnchor.constraint(equalTo: menuBackgroundView.topAnchor, constant: 20).isActive = true
        trackerView.leadingAnchor.constraint(equalTo: menuBackgroundView.leadingAnchor, constant: 20).isActive = true
        trackerView.trailingAnchor.constraint(equalTo: menuBackgroundView.trailingAnchor, constant: 20).isActive = true
        trackerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        trackerView.widthAnchor.constraint(equalTo: menuBackgroundView.widthAnchor, constant: -40).isActive = true
    }

    func setUpBarChartView() {
        let axisLabelConfig = FLAxesLabelConfig(color: .white)
        let axesLinesConfig = FLAxesLineConfig(color: .white)
        let dashedLineConfig = FLDashedLineConfig(color: .white)
        let config = FLChartConfig(granularityX: 2, axesLabels: axisLabelConfig, axesLines: axesLinesConfig, dashedLines: dashedLineConfig)

        let chartData = setUpChartData()
        let chart = FLChart(data: chartData, type: .bar())
        chart.config = config

        let card = FLCard(chart: chart, style: .rounded)
        card.showAverage = false
        card.showLegend = true
        let cardConfig = FLCardStyle(backgroundColor: Attributes.Colors.accentBlueGrey, textColor: .white, cornerRadius: 50)

        card.backgroundColor = Attributes.Colors.accentBlueGrey
        card.setup(chart: chart, style: cardConfig)

        menuBackgroundView.addArrangedSubview(card)

        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 200).isActive = true

        let separatorView = UIView()
        menuBackgroundView.addArrangedSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }

    @objc func proceedToAttackTracking() {
        output.addButtonTapped()
    }

    private func setUpChartData() -> FLChartData {
        let monthsData = [
            MultiPlotable(name: "jan", values: [1, 2, 3]),
            MultiPlotable(name: "feb", values: [2, 3, 4]),
            MultiPlotable(name: "mar", values: [0, 1, 3]),
            MultiPlotable(name: "apr", values: [4, 4, 3]),
            MultiPlotable(name: "may", values: [2, 2, 1]),
            MultiPlotable(name: "jun", values: [8, 5, 3]),
            MultiPlotable(name: "jul", values: [9, 5, 0]),
            MultiPlotable(name: "aug", values: [3, 8, 1]),
            MultiPlotable(name: "set", values: [0, 1, 3]),
            MultiPlotable(name: "oct", values: [5, 2, 4]),
            MultiPlotable(name: "nov", values: [1, 1, 1]),
            MultiPlotable(name: "dec", values: [1])
        ]

        let chartData = FLChartData(
            title: "Anxiety attacks and causes ",
            data: monthsData,
            legendKeys: [
                Key(key: "Personal", color: .init(hex: "A1C7DD")),
                Key(key: "Financial", color: .init(hex: "B4CBDF")),
                Key(key: "External", color: .init(.white))
            ],
            unitOfMeasure: "Frequency"
        )
        return chartData
    }

    private func setUpCalendarView() {
        menuBackgroundView.addArrangedSubview(calendarView)
        calendarView.delegate = self
    }
}

// MARK: - DashboardPresenterOutput

extension DashboardViewController: DashboardPresenterOutput {

    // MARK: - Displxay logic
    func update(with viewModel: DashboardViewModel) {
        view.backgroundColor = viewModel.backgroundColour
        calendarView.update(with: .init(days: viewModel.days, baseDate: viewModel.baseDate, numberOfWeeksInBaseDate: viewModel.numberOfWeeksInBaseDate))
        view.setNeedsLayout()

    }
}

// MARK: - CalendarViewOutput

extension DashboardViewController: CalendarViewOutput {
    func reloadData(forDate: Date) {
        calendarView.reloadData(forDate: forDate)
    }
}

// MARK: - TrackerViewDelegate

extension DashboardViewController: TrackerViewDelegate {
    func proceedToAttackTracking() {
        output.addButtonTapped()
    }
}
