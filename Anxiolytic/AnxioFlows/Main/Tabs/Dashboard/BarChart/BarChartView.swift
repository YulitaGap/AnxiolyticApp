import UIKit
import FLCharts

class BarChartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
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

        self.addSubview(card)

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
}
