//
//  HistoryInteractor.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

class HistoryInteractor: HistoryInteractorProtocol {
    weak var delegate: HistoryInteractorDelegate?
    private let repository: HistoryRepositoryProtocol
    private(set) var transactions: [Transaction] = .init()
    
    init(repository: HistoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getTransactions(by type: String) {
        self.transactions = self.repository.getTransactions(by: type)
        self.delegate?.didFinish()
    }
}
