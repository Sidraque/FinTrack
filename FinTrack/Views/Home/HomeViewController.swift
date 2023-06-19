//
//  HomeViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeView: HomeView!
    private var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        setupView()
    }

    private func setupView() {
        // Configure Home View
        homeView = HomeView()
        homeView.delegate = self
        homeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeView)

        // Constraints
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewDelegate {
    func addCategoryButtonTapped() {
        let addCategoryPopup = AddCategoryPopupViewController()
        addCategoryPopup.modalPresentationStyle = .formSheet
        addCategoryPopup.modalTransitionStyle = .coverVertical
        present(addCategoryPopup, animated: true, completion: nil)
    }

    func addTransactionButtonTapped() {
        let addTransactionPopup = AddTransactionPopupViewController(categories: categories)
        addTransactionPopup.modalPresentationStyle = .formSheet
        addTransactionPopup.modalTransitionStyle = .coverVertical
        present(addTransactionPopup, animated: true, completion: nil)
    }
    
    func profileButtonTapped() {
       let profileViewController = ProfileViewController()
       navigationController?.pushViewController(profileViewController, animated: true)
   }
}
