//
//  AddTransactionPopupViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class AddTransactionPopupViewController: UIViewController {
    private var addTransactionPopupView: AddTransactionPopupView!
    private var saveButton: UIButton!
    
    private var categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        addTransactionPopupView = AddTransactionPopupView(categories: categories)
        addTransactionPopupView.delegate = self
        view = addTransactionPopupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Salvar", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        addTransactionPopupView.addButton(saveButton)
    }
    
    @objc private func saveButtonTapped() {
        guard let title = addTransactionPopupView.transactionTitleField.text,
              let valueText = addTransactionPopupView.transactionValueField.text,
              let value = Double(valueText),
              let selectedCategory = addTransactionPopupView.selectedCategory else {
            return
        }
        
        let transaction = Transaction(title: title, value: value, category: selectedCategory)
        // Salvar a transação
        
        dismiss(animated: true, completion: nil)
    }
}

extension AddTransactionPopupViewController: AddTransactionPopupDelegate {
    func didSelectCategory(_ category: Category?) {
        guard let category = category else {
            // Lidar com a seleção vazia ou nula da categoria
            return
        }
        
        // Atualizar a categoria selecionada
    }
}
