//
//  HomeView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func addCategoryButtonTapped()
    func addTransactionButtonTapped()
    func profileButtonTapped()
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    
    private let totalAmountLabel: UILabel
    private let piggyBankImageView: UIImageView
    private let addCategoryButton: UIButton
    private let addTransactionButton: UIButton
    private let profileButton: UIButton

    override init(frame: CGRect) {
        totalAmountLabel = UILabel()
        piggyBankImageView = UIImageView()
        addCategoryButton = UIButton()
        addTransactionButton = UIButton()
        profileButton = UIButton()

        super.init(frame: frame)

        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        totalAmountLabel = UILabel()
        piggyBankImageView = UIImageView()
        addCategoryButton = UIButton()
        addTransactionButton = UIButton()
        profileButton = UIButton()

        super.init(coder: coder)

        setupUI()
        setupActions()
    }

    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)

        backgroundColor = UIColor.white

        // Total Amount Label
        totalAmountLabel.textAlignment = .center
        totalAmountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(totalAmountLabel)

        // Piggy Bank Image View
        piggyBankImageView.image = UIImage(named: "piggy_bank")
        piggyBankImageView.contentMode = .scaleAspectFit
        piggyBankImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(piggyBankImageView)

        // Add Category Button
        addCategoryButton.setTitle("Adicionar Categoria", for: .normal)
        addCategoryButton.setTitleColor(.blue, for: .normal)
        addCategoryButton.backgroundColor = UIColor.systemGray5
        addCategoryButton.layer.cornerRadius = 8
        addCategoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addCategoryButton)

        // Add Transaction Button
        addTransactionButton.setTitle("Adicionar Transação", for: .normal)
        addTransactionButton.setTitleColor(.blue, for: .normal)
        addTransactionButton.backgroundColor = UIColor.systemGray5
        addTransactionButton.layer.cornerRadius = 8
        addTransactionButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addTransactionButton)

        // Profile Button
        profileButton.setTitle("👤", for: .normal)
        profileButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        profileButton.setTitleColor(.black, for: .normal)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileButton)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Total Amount Label
            totalAmountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalAmountLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),

            // Piggy Bank Image View
            piggyBankImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            piggyBankImageView.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 16),
            piggyBankImageView.widthAnchor.constraint(equalToConstant: 100),
            piggyBankImageView.heightAnchor.constraint(equalToConstant: 100),

            // Add Category Button
            addCategoryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addCategoryButton.topAnchor.constraint(equalTo: piggyBankImageView.bottomAnchor, constant: 32),
            addCategoryButton.heightAnchor.constraint(equalToConstant: 50),

            // Add Transaction Button
            addTransactionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addTransactionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addTransactionButton.topAnchor.constraint(equalTo: addCategoryButton.bottomAnchor, constant: 16),
            addTransactionButton.heightAnchor.constraint(equalToConstant: 50),

            // Profile Button
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            profileButton.widthAnchor.constraint(equalToConstant: 44),
            profileButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupActions() {
        addCategoryButton.addTarget(self, action: #selector(addCategoryButtonTapped), for: .touchUpInside)
        addTransactionButton.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }

    @objc private func handleTap() {
        endEditing(true)
    }

    @objc private func addCategoryButtonTapped() {
        delegate?.addCategoryButtonTapped()
    }

    @objc private func addTransactionButtonTapped() {
        delegate?.addTransactionButtonTapped()
    }

    @objc private func profileButtonTapped() {
        delegate?.profileButtonTapped()
    }
}
