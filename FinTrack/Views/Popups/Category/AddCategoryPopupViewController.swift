//
//  AddCategoryPopupViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class AddCategoryPopupViewController: UIViewController {
    private var addCategoryPopupView: AddCategoryPopupView!
    private var saveButton: UIButton!
    
    private var completion: ((String, String, String) -> Void)?
    
    convenience init(completion: @escaping (String, String, String) -> Void) {
        self.init()
        self.completion = completion
    }
    
    override func loadView() {
        addCategoryPopupView = AddCategoryPopupView()
        view = addCategoryPopupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Salvar", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        addCategoryPopupView.addButton(saveButton)
    }
    
    @objc private func saveButtonTapped() {
        guard let name = addCategoryPopupView.categoryName,
              let type = addCategoryPopupView.categoryType,
              let emoji = addCategoryPopupView.categoryEmoji else {
            return
        }
        
        completion?(name, type, emoji)
        dismiss(animated: true, completion: nil)
    }
}
