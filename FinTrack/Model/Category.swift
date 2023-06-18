//
//  Category.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import Foundation

struct Category {
    let name: String
    let type: CategoryType
    let emoji: String
}

enum CategoryType: String {
    case revenue
    case expense
}
