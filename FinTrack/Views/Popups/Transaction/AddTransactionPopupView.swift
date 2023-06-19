//
//  AddTransactionPopupView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

protocol AddTransactionPopupViewDelegate: AnyObject {
    func saveTransactionButtonTapped(title: String, value: Double, category: Category)
}

class AddTransactionPopupView: UIView {
    weak var delegate: AddTransactionPopupViewDelegate?

    private let titleLabel: UILabel
    private let valueTextField: UITextField
    private let categoryPickerView: UIPickerView
    private let saveButton: UIButton

    private let categories: [Category] // Assuming Category is a model class

    init(categories: [Category]) {
        self.categories = categories

        titleLabel = UILabel()
        valueTextField = UITextField()
        categoryPickerView = UIPickerView()
        saveButton = UIButton()

        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        
        backgroundColor = UIColor.white
        
        // Configure titleLabel
        titleLabel.text = "Title"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // Configure valueTextField
        valueTextField.placeholder = "Value"
        valueTextField.textColor = .black
        valueTextField.borderStyle = .roundedRect
        valueTextField.layer.cornerRadius = 15
        valueTextField.font = UIFont.systemFont(ofSize: 16)
        valueTextField.keyboardType = .decimalPad
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueTextField)

        // Configure categoryPickerView
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoryPickerView)

        // Configure saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.cornerRadius = 28
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveButton)

        // Add subviews and set up constraints
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // valueTextField
            valueTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            valueTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            valueTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            valueTextField.heightAnchor.constraint(equalToConstant: 40),

            // categoryPickerView
            categoryPickerView.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: 20),
            categoryPickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryPickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            categoryPickerView.heightAnchor.constraint(equalToConstant: 150),

            // saveButton
            saveButton.topAnchor.constraint(equalTo: categoryPickerView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])

        // Add target action for saveButton tapped event
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    // Handle save button tapped event
    @objc private func saveButtonTapped() {
        guard let title = titleLabel.text,
              let valueText = valueTextField.text,
              let value = Double(valueText),
              categoryPickerView.selectedRow(inComponent: 0) < categories.count else {
            return
        }
        
        let selectedCategory = categories[categoryPickerView.selectedRow(inComponent: 0)]

        delegate?.saveTransactionButtonTapped(title: title, value: value, category: selectedCategory)
    }
    
    @objc private func handleTap() {
        endEditing(true)
    }
}

extension AddTransactionPopupView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
}
