//
//  HomeViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    private var homeView: HomeView!
    private var viewModel: HomeViewModel!
    private var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView = HomeView()
        homeView.delegate = self
        view = homeView
        
        viewModel = HomeViewModel()
        
        viewModel.loadCategories { [weak self] loadedCategories in
            self?.categories = loadedCategories
            self?.homeView.updateCategories(loadedCategories)
        }
    }
    
    func addCategoryButtonTapped() {
        let addCategoryPopupViewController = AddCategoryPopupViewController { [weak self] name, type, emoji in
            self?.handleNewCategory(name: name, type: type, emoji: emoji)
        }
        present(addCategoryPopupViewController, animated: true, completion: nil)
    }
    
    func addTransactionButtonTapped() {
        let addTransactionPopupViewController = AddTransactionPopupViewController(categories: categories)
        present(addTransactionPopupViewController, animated: true, completion: nil)
    }
    
    private func handleNewCategory(name: String, type: String, emoji: String) {
        guard let categoryType = CategoryType(rawValue: type) else {
            return
        }
        
        let newCategory = Category(name: name, type: categoryType, emoji: emoji)
        viewModel.saveCategory(newCategory)
        
        categories.append(newCategory)
        homeView.updateCategories(categories)
    }
}
