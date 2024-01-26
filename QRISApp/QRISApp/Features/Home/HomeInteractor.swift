//
//  HomeInteractor.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

class HomeInteractor: PHomeInteractor {
    func pay(_ t: Transaction) -> User.PaymentResult {
        return self.repository.pay(t)
    }
    
    func getUser() -> User {
        return self.repository.getUser()
    }
    
    func getHistory() -> [Transaction] {
        return self.repository.getHistory()
    }
    
    private let repository: PHomeRepository
    
    init(repository: PHomeRepository) {
        self.repository = repository
    }
}
