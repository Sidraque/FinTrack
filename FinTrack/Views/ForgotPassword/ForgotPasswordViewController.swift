//
//  ForgotPasswordViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 14/06/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    private var forgotPasswordView: ForgotPasswordView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        setupForgotPasswordView()
    }

    private func setupForgotPasswordView() {
        forgotPasswordView = ForgotPasswordView()
        forgotPasswordView.delegate = self
        forgotPasswordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forgotPasswordView)

        NSLayoutConstraint.activate([
            forgotPasswordView.topAnchor.constraint(equalTo: view.topAnchor),
            forgotPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forgotPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forgotPasswordView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewDelegate {
    func resetPasswordButtonTapped(email: String) {
        // Implementar ação para redefinir a senha do usuário com o email fornecido
    }

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

