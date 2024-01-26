//
//  DataSource.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    
    private var portofolio: [PortofolioData]
    
    init() {
         portofolio = [
            DonutChartPortofolio(label: "Tarik Tunai", percentage: "55", data: [
                Transaction(trxDate: "21/01/2023", nominal: 1000000),
                Transaction(trxDate: "20/01/2023", nominal: 500000),
                Transaction(trxDate: "19/01/2023", nominal: 1000000)
            ]),
            DonutChartPortofolio(label: "QRIS Payment", percentage: "31", data: [
                Transaction(trxDate: "21/01/2023", nominal: 159000),
                Transaction(trxDate: "20/01/2023", nominal: 35000),
                Transaction(trxDate: "19/01/2023", nominal: 1500)
            ]),
            DonutChartPortofolio(label: "Topup Gopay", percentage: "7.7", data: [
                Transaction(trxDate: "21/01/2023", nominal: 200000),
                Transaction(trxDate: "20/01/2023", nominal: 195000),
                Transaction(trxDate: "19/01/2023", nominal: 5000000)
            ]),
            DonutChartPortofolio(label: "Lainnya", percentage: "6.3", data: [
                Transaction(trxDate: "21/01/2023", nominal: 1000000),
                Transaction(trxDate: "20/01/2023", nominal: 500000),
                Transaction(trxDate: "19/01/2023", nominal: 1000000)
            ]),
            LineChartPortofolio(data: MonthlyData(month: [3, 7, 8, 10, 5, 10, 1, 3, 5, 10, 7, 7]))
        ]

    }
    
    func getPortofolio() -> [PortofolioData] {
        return self.portofolio
    }
    
    func getTransactions(by type: String) -> [Transaction] {
        var transactions: [Transaction] = []
        for data in portofolio {
            if let donutData = data as? DonutChartPortofolio, donutData.label == type {
                transactions.append(contentsOf: donutData.data)
                break
            }
        }
        
        return transactions
    }
}
