//
//  HomeRepositorySuccessMock.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

#if DEBUG
import Foundation

class HomeRepositorySuccessMock: PHomeRepository {
    func getUser() -> User {
        return client.getUser()
    }
    
    func pay(_ t: Transaction) -> User.PaymentResult {
        return client.pay(transaction: t)
    }
    
    func getHistory() -> [Transaction] {
        return client.getTransactionsHistory()
    }
    
    private let client: DataStore
    
    init() {
        self.client = DataStore(withUser: User(name: "Ley Test", balance: 100_000))
    }
}

class HomeInteractorMock: PHomeInteractor {
    func getUser() -> User {
        return repository.getUser()
    }
    
    func pay(_ t: Transaction) -> User.PaymentResult {
        return repository.pay(t)
    }
    
    func getHistory() -> [Transaction] {
        return repository.getHistory()
    }
    
    private let repository: PHomeRepository
    
    init(repository: PHomeRepository) {
        self.repository = repository
    }
    
}

#endif
