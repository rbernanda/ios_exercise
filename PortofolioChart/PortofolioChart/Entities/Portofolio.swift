//
//  Portofolio.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

enum ChartType: String, Codable {
    case donutChart = "donutChart"
    case lineChart = "lineChart"
}

protocol PortofolioData: Codable {
    var type: ChartType { get }
}

struct Transaction: Codable {
    let trxDate: String
    let nominal: Int
}

struct DonutChartPortofolio: Codable, PortofolioData {
    var type = ChartType.donutChart
    let label: String
    let percentage: String
    let data: [Transaction]
}

struct MonthlyData: Codable {
    let month: [Int]
}

struct LineChartPortofolio: Codable, PortofolioData {
    var type = ChartType.lineChart
    let data: MonthlyData
}
