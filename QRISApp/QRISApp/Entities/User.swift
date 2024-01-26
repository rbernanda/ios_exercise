//
//  User.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

struct User: Codable {
    let name: String
    var balance: Decimal
    
    enum PaymentResult {
        case success
        case invalidAmount
        case insufficientFunds
    }
    
    mutating func pay(amount: Decimal) -> PaymentResult {
        guard amount > 0 else { return .invalidAmount }
        
        guard balance >= amount else { return .insufficientFunds }
        
        balance -= amount
        return .success
    }
}
