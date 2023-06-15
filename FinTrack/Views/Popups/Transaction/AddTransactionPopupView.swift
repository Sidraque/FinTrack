//
//  AddTransactionPopupView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

protocol AddTransactionPopupDelegate: AnyObject {
    func didSelectCategory(_ category: Category?)
}

class AddTransactionPopupView: UIView {
    private var titleLabel: UILabel!
    private var valueLabel: UILabel!
    private var categoryLabel: UILabel!
    
    var transactionTitleField: UITextField!
    var transactionValueField: UITextField!
    private var categoryPickerView: UIPickerView!
    
    private var saveButton: UIButton!
    
    private var categories: [Category]
    
    weak var delegate: AddTransactionPopupDelegate?
    var selectedCategory: Category?
    
    init(categories: [Category]) {
        self.categories = categories
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configurar a interface do usuário para adicionar uma transação
        // Inclua os campos necessários, como título, valor e seleção de categoria
        // Configure o picker view com as categorias disponíveis
        
        // Exemplo:
        titleLabel = UILabel()
        titleLabel.text = "Título:"
        addSubview(titleLabel)
        
        transactionTitleField = UITextField()
        transactionTitleField.placeholder = "Insira o título"
        addSubview(transactionTitleField)
        
        // Configurar outros elementos da interface do usuário
        
        categoryPickerView = UIPickerView()
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        addSubview(categoryPickerView)
        
        // Configurar layout e restante da interface do usuário
    }
    
    func addButton(_ button: UIButton) {
        saveButton = button
        // Adicionar o botão à interface do usuário
    }
}

extension AddTransactionPopupView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        delegate?.didSelectCategory(selectedCategory)
    }
}
