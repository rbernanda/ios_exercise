//
//  Transaction.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let id: UUID
    let transactionID: String
    let amount: Decimal
    let sourceBank: String
    let merchantName: String
    let createdAt: Date
    
    init(transactionID: String, amount: Decimal, sourceBank: String, merchantName: String) {
        self.id = UUID()
        self.transactionID = transactionID
        self.amount = amount
        self.sourceBank = sourceBank
        self.merchantName = merchantName
        self.createdAt = Date()
    }
}

