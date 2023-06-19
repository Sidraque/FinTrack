//
//  HomeViewModel.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func totalAmountDidChange(_ viewModel: HomeViewModel)
    func categoriesDidChange(_ viewModel: HomeViewModel)
}

class HomeViewModel {
    private var totalAmount: Double = 0
    private var categories: [Category] = []
    
    weak var delegate: HomeViewModelDelegate?
    
    var formattedTotalAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: totalAmount)) ?? ""
    }
    
    var numberOfCategories: Int {
        return categories.count
    }
    
    func category(at index: Int) -> Category? {
        guard index >= 0 && index < categories.count else {
            return nil
        }
        return categories[index]
    }
    
    func addCategory(name: String, type: CategoryType, emoji: String) {
        let category = Category(name: name, type: type, emoji: emoji)
        categories.append(category)
        delegate?.categoriesDidChange(self)
    }
    
    func addTransaction(title: String, value: Double, category: Category) {
        let transaction = Transaction(title: title, value: value, category: category)
        
        if category.type == .revenue {
            totalAmount += value
        } else if category.type == .expense {
            totalAmount -= value
        }
        
        delegate?.totalAmountDidChange(self)
        
        // Aqui você pode armazenar a transação em uma lista ou fazer qualquer outro processamento necessário
    }
}
