//
//  ViewController.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import UIKit
import DGCharts
import TinyConstraints

class HomeViewController: UIViewController {
    private let interactor: HomeInteractor
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        interactor.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var containerVw: UIView = {
       let vw = UIView()
       return vw
    }()
    
    private lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemGreen
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .clear
        
        chartView.xAxis.labelPosition = .bottom
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .clear
        
        chartView.animate(xAxisDuration: 2)
        
        return chartView
    }()
    
    private lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.backgroundColor = .systemGreen
        chartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.xEntrySpace = 0
        l.yEntrySpace = 0
        l.yOffset = 2
        
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerVw)
        view.addSubview(lineChartView)
        view.addSubview(pieChartView)
        
        lineChartView.width(to: view)
        lineChartView.height(UIScreen.main.bounds.height * 0.30)
        
        pieChartView.width(to: view)
        pieChartView.height(UIScreen.main.bounds.height * 0.40)
        pieChartView.delegate = self
        
        containerVw.edgesToSuperview(usingSafeArea: true)
        containerVw.stack([lineChartView, pieChartView], axis: .vertical, spacing: 10)
        
        interactor.getPortofolio()
    }
}

extension HomeViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard chartView === pieChartView,
        let label = entry.value(forKey: "label") as? String else { return }
        print("ENTRY", label)
        
        let historyRepository = HistoryRepository()
        let historyInteractor = HistoryInteractor(repository: historyRepository)
        let historyVC = HistoryViewController(interactor: historyInteractor, transactionType: label)
        
        self.navigationController?.pushViewController(historyVC, animated: true)
        
    }
    
    func setLineChartData() {
        var lineChartEntries: [ChartDataEntry] = []
        
        for data in interactor.portofolio {
            if let lineChartData = data as? LineChartPortofolio {
                for (index, month) in lineChartData.data.month.enumerated() {
                    let entry = ChartDataEntry(x: Double(index), y: Double(month))
                    lineChartEntries.append(entry)
                }
            }
        }
        
        let lineChartSet = LineChartDataSet(entries: lineChartEntries, label: "Month")
        lineChartSet.mode = .cubicBezier
        lineChartSet.drawCirclesEnabled = false
        lineChartSet.lineWidth = 3
        lineChartSet.setColor(.white)
        lineChartSet.fill = ColorFill(color: .white)
        lineChartSet.fillAlpha = 0.5
        lineChartSet.drawFilledEnabled = true
        
        lineChartSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartSet.highlightColor = .systemRed
        
        let lineChartData = LineChartData(dataSet: lineChartSet)
        lineChartData.setDrawValues(false)
        
        lineChartView.data = lineChartData
    }
    
    func setDonutChartData() {
        var entries: [PieChartDataEntry] = []
        
        for data in interactor.portofolio {
            if let donutData = data as? DonutChartPortofolio {
                guard let percentage = Double(donutData.percentage) else { continue }
                let entry = PieChartDataEntry(value: percentage, label: donutData.label)
                entries.append(entry)
            }
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = ChartColorTemplates.colorful()
        
        let data = PieChartData(dataSet: dataSet)
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .medium))
        data.setValueTextColor(.white)
        pieChartView.data = data
        pieChartView.highlightValue(nil)
    }
}

extension HomeViewController: HomeInteractorDelegate {
    func didFinish() {
        setLineChartData()
        setDonutChartData()
    }
}

