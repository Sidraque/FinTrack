//
//  AddCategoryPopupView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

protocol AddCategoryPopupViewDelegate: AnyObject {
    func saveCategoryButtonTapped(name: String, type: String, emoji: String)
    func cancelButtonTapped()
    func categorySaved(_ category: Category) // Adicione este método ao protocolo
}

class AddCategoryPopupView: UIView {
    weak var delegate: AddCategoryPopupViewDelegate?
    
    private let nameLabel: UILabel
    private let nameTextField: UITextField
    private let typeSegmentedControl: UISegmentedControl
    private let emojiLabel: UILabel
    private let emojiTextField: UITextField
    private let saveButton: UIButton
    private let cancelButton: UIButton
    
    init() {
        nameLabel = UILabel()
        nameTextField = UITextField()
        typeSegmentedControl = UISegmentedControl(items: ["Receita", "Despesa"])
        emojiLabel = UILabel()
        emojiTextField = UITextField()
        saveButton = UIButton()
        cancelButton = UIButton()
        
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
        
        // Configure nameLabel
        nameLabel.text = "Nome:"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        // Configure nameTextField
        nameTextField.placeholder = "Digite o nome"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameTextField)
        
        // Configure typeSegmentedControl
        typeSegmentedControl.selectedSegmentIndex = 0
        typeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typeSegmentedControl)
        
        // Configure emojiLabel
        emojiLabel.text = "Emoji:"
        emojiLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emojiLabel)
        
        // Configure emojiTextField
        emojiTextField.placeholder = "Digite o emoji"
        emojiTextField.borderStyle = .roundedRect
        emojiTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emojiTextField)
        
        // Configure saveButton
        saveButton.setTitle("Salvar", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.cornerRadius = 8
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveButton)
        
        // Configure cancelButton
        cancelButton.setTitle("Cancelar", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = .systemRed
        cancelButton.layer.cornerRadius = 8
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        
        // Add subviews and set up constraints
        NSLayoutConstraint.activate([
            // nameLabel
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // nameTextField
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // typeSegmentedControl
            typeSegmentedControl.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            typeSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            typeSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // emojiLabel
            emojiLabel.topAnchor.constraint(equalTo: typeSegmentedControl.bottomAnchor, constant: 16),
            emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // emojiTextField
            emojiTextField.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 8),
            emojiTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emojiTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // saveButton
            saveButton.topAnchor.constraint(equalTo: emojiTextField.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            
            // cancelButton
            cancelButton.topAnchor.constraint(equalTo: emojiTextField.bottomAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Add target actions
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    // Handle save button tapped event
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text,
              let emoji = emojiTextField.text else {
            return
        }
        
        let type: String
        if typeSegmentedControl.selectedSegmentIndex == 0 {
            type = "Receita"
        } else {
            type = "Despesa"
        }
        
        delegate?.saveCategoryButtonTapped(name: name, type: type, emoji: emoji)
    }
    
    // Handle cancel button tapped event
    @objc private func cancelButtonTapped() {
        delegate?.cancelButtonTapped()
    }
    
    @objc private func handleTap() {
        endEditing(true)
    }
}
