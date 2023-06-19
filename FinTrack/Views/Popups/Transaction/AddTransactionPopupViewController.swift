//
//  AddTransactionPopupViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class AddTransactionPopupViewController: UIViewController {
    let popupView: AddTransactionPopupView
    private let categories: [Category]

    init(categories: [Category]) {
        self.categories = categories
        popupView = AddTransactionPopupView(categories: categories)
        super.init(nibName: nil, bundle: nil)
        popupView.delegate = self
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = popupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
    }
}

extension AddTransactionPopupViewController: AddTransactionPopupViewDelegate {
    func saveTransactionButtonTapped(title: String, value: Double, category: Category) {
        let transaction = Transaction(title: title, value: value, category: category)
        
        // Handle save transaction logic using the transaction object
        
        // For example, you can print the transaction details
        print("Transaction Saved:")
        print("Title: \(transaction.title)")
        print("Value: \(transaction.value)")
        print("Category: \(transaction.category.name)")
        
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
