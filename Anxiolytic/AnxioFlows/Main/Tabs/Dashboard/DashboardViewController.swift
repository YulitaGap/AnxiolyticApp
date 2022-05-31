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
}

/**
  The `DashboardViewController` communicates with the `DashboardInteractor,
  and gets a response back from the `DashboardPresenter`.
 */
final class DashboardViewController: UIViewController {

    var output: DashboardViewControllerOutput!

    private lazy var calendarView = CalendarView()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(containerStackView)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
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
        setUpScrollView()
        setUpTrackerView()
        setUpCalendarView()
        setUpBarChartView()
    }

    private func setUpScrollView() {
        let view = UIView()
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0).isActive = true

        setUpStackView()
        self.view = view
    }

    private func setUpStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        containerStackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
    }

    private func setUpTrackerView() {
        let attackTracker: UIView = UIView(frame: CGRect(x: 0, y: 20, width: view.bounds.width, height: 80))
        containerStackView.addArrangedSubview(attackTracker)
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
        let cardConfig = FLCardStyle(backgroundColor: Attributes.Colors.accentBlueGrey, textColor: .white, cornerRadius: 30)

        card.backgroundColor = Attributes.Colors.accentBlueGrey
        card.setup(chart: chart, style: cardConfig)

        containerStackView.addArrangedSubview(card)

        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 50).isActive = true

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
        containerStackView.addArrangedSubview(calendarView)
        calendarView.delegate = self
        calendarView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
}

// MARK: - DashboardPresenterOutput

extension DashboardViewController: DashboardPresenterOutput {

    // MARK: - Display logic

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
