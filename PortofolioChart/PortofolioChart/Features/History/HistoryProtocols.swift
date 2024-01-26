//
//  HistoryProtocols.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

protocol HistoryInteractorProtocol {
    func getTransactions(by type: String)
}

protocol HistoryRepositoryProtocol {
    func getTransactions(by type: String) -> [Transaction]
}

protocol HistoryInteractorDelegate: AnyObject {
    func didFinish()
}
