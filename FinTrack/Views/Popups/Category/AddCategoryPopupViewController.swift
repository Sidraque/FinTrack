//
//  AddCategoryPopupViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class AddCategoryPopupViewController: UIViewController {
    let popupView: AddCategoryPopupView
    weak var delegate: AddCategoryPopupViewDelegate?

    init() {
        popupView = AddCategoryPopupView()
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

extension AddCategoryPopupViewController: AddCategoryPopupViewDelegate {
    func saveCategoryButtonTapped(name: String, type: String, emoji: String) {
        // Handle save category logic

        let categoryType: CategoryType
        
        switch type {
        case "Receita":
            categoryType = .revenue
        case "Despesa":
            categoryType = .expense
        default:
            // Handle unrecognized type
            return
        }

        let category = Category(name: name, type: categoryType, emoji: emoji)

        // Informe o delegate que a categoria foi salva
        delegate?.categorySaved(category)

        // Feche a janela de popup
        dismiss(animated: true, completion: nil)
    }

    func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func categorySaved(_ category: Category) {
        // Implemente as ações necessárias ao salvar a categoria
    }
}
