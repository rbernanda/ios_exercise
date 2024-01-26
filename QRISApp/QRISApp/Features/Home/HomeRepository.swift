//
//  HomeRepository.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

class HomeRepository: PHomeRepository {
    func getHistory() -> [Transaction] {
        return client.getTransactionsHistory()
    }
    
    func pay(_ t: Transaction) -> User.PaymentResult {
        return client.pay(transaction: t)
    }
    
    func getUser() -> User {
        return client.getUser()
    }
    
    private let client: DataStore
    
    init() {
        self.client = DataStore.shared
    }
}
