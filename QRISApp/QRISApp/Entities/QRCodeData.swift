//
//  QRCodeData.swift
//  QRISApp
//
//  Created by Roli Bernanda on 25/01/24.
//

import Foundation

struct QRCodeData {
    var sourceBank: String
    var transactionID: String
    var merchantName: String
    var transactionAmount: Decimal

    init?(qrCodeString: String) {
        let components = qrCodeString.components(separatedBy: ".")

        guard components.count == 4 else {
            return nil
        }

        self.sourceBank = components[0]
        self.transactionID = components[1]
        self.merchantName = components[2]

        if let amount = Decimal(string: components[3]) {
            self.transactionAmount = amount
        } else {
            return nil
        }
    }
}

