//
//  Transaction.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import Foundation

struct Transaction {
    let title: String
    let value: Double
    let category: Category
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
