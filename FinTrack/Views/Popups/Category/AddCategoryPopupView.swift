//
//  AddCategoryPopupView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class AddCategoryPopupView: UIView {
    private var nameLabel: UILabel!
    private var typeLabel: UILabel!
    private var emojiLabel: UILabel!
    
    private var nameTextField: UITextField!
    private var typeSegmentedControl: UISegmentedControl!
    private var emojiTextField: UITextField!
    
    private var saveButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configurar a interface do usuário para adicionar uma nova categoria
        // Inclua os campos necessários, como nome, tipo e emoji
    }
    
    func addButton(_ button: UIButton) {
        saveButton = button
        // Adicionar o botão à interface do usuário
    }
    
    var categoryName: String? {
        return nameTextField.text
    }
    
    var categoryType: String? {
        let selectedIndex = typeSegmentedControl.selectedSegmentIndex
        return typeSegmentedControl.titleForSegment(at: selectedIndex)
    }
    
    var categoryEmoji: String? {
        return emojiTextField.text
    }
}
