//
//  Protocols.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

protocol PHomeInteractor {
    func getUser() -> User
    func pay(_ t: Transaction) -> User.PaymentResult
    func getHistory() -> [Transaction]
}

protocol PHomeRepository {
    func getUser() -> User
    func pay(_ t: Transaction) -> User.PaymentResult
    func getHistory() -> [Transaction]
}
