//
//  Numeric+Extension.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import Foundation

extension Numeric {
    func formatAsMoney(locale: Locale = Locale.current, currencySymbol: String? = nil) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        
        if let currencySymbol = currencySymbol {
            formatter.currencySymbol = currencySymbol
        }
        
        return formatter.string(from: self as? NSNumber ?? NSNumber(value: 0))
    }
}
