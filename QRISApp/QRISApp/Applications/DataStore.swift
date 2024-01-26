//
//  DataStore.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    
    private var transactionsHistory: [Transaction]
    private var user: User
    
    init() {
        self.transactionsHistory = .init()
        self.user = .init(name: "LeyLey", balance: 1_000_000)
    }
    
    init(withUser user: User) {
        self.transactionsHistory = .init()
        self.user = user
    }
    
    func pay(transaction: Transaction) -> User.PaymentResult {
        let paymentResult = user.pay(amount: transaction.amount)
        
        switch paymentResult {
        case .success:
            transactionsHistory.append(transaction)
            return .success
        case .insufficientFunds:
            return .insufficientFunds
        case .invalidAmount:
            return .invalidAmount
        }
    }
    
    func getUser() -> User {
        return self.user
    }
    
    func getTransactionsHistory() -> [Transaction] {
        return self.transactionsHistory.sorted { $0.createdAt > $1.createdAt }
    }
    
    // MARK: FOR JSON file persistence
    
    //    private init() {
    //        Task {
    //            do {
    //                try await self.load()
    //            } catch {
    //                print("Failed to load data: \(error)")
    //            }
    //        }
    //    }
    //
    //    private static func fileURL(for fileName: String) throws -> URL {
    //        try FileManager.default.url(for: .documentDirectory,
    //                                    in: .userDomainMask,
    //                                    appropriateFor: nil,
    //                                    create: false)
    //        .appendingPathComponent(fileName)
    //    }
    //
    //    private func load() async throws {
    //        // Load transactions
    //        let transactionTask = Task<[Transaction], Error> {
    //            let fileURL = try Self.fileURL(for: "transactions_history.data")
    //            guard let data = try? Data(contentsOf: fileURL) else {
    //                return []
    //            }
    //            let transactions = try JSONDecoder().decode([Transaction].self, from: data)
    //            return transactions
    //        }
    //        let transactions = try await transactionTask.value
    //        self.transactionsHistory = transactions
    //
    //        // Load user data
    //        let userTask = Task<User, Error> {
    //            let fileURL = try Self.fileURL(for: "user.data")
    //            guard let data = try? Data(contentsOf: fileURL) else {
    //                return User()
    //            }
    //            let user = try JSONDecoder().decode(User.self, from: data)
    //            return user
    //        }
    //        self.user = try await userTask.value
    //    }
    //
    //    private func saveTransactions() async throws {
    //        let task = Task {
    //            let data = try JSONEncoder().encode(transactionsHistory)
    //            let fileURL = try Self.fileURL(for: "transactions_history.data")
    //            try data.write(to: fileURL)
    //        }
    //        try await task.value
    //    }
    //
    //    private func saveUser() async throws {
    //        let task = Task {
    //            let data = try JSONEncoder().encode(user)
    //            let fileURL = try Self.fileURL(for: "user.data")
    //            try data.write(to: fileURL)
    //        }
    //        try await task.value
    //    }
}
