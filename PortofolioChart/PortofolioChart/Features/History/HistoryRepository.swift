//
//  HistoryRepository.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

class HistoryRepository: HistoryRepositoryProtocol {
    func getTransactions(by type: String) -> [Transaction] {
        return self.client.getTransactions(by: type)
    }
    
    let client: DataStore
    
    init() {
        self.client = DataStore.shared
    }
    
}
