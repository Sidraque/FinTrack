//
//  ForgotPasswordViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 14/06/23.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    private var forgotPasswordView: ForgotPasswordView!
    private var viewModel: ForgotPasswordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        setupForgotPasswordView()
        setupViewModel()
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

    private func setupViewModel() {
        viewModel = ForgotPasswordViewModel()
        viewModel.delegate = self
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewDelegate {
    func resetPasswordButtonTapped(email: String) {
        let model = ForgotPasswordModel(email: email)
        viewModel.resetPassword(with: model)
    }

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewModelDelegate {
    func resetPasswordSuccess() {
        let alertController = UIAlertController(title: "Redefinição de senha enviada", message: "Um e-mail com as instruções para redefinir a senha foi enviado para o endereço fornecido.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }

    func resetPasswordFailure(error: Error) {
        let alertController = UIAlertController(title: "Erro", message: getErrorMessage(for: error), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    private func getErrorMessage(for error: Error) -> String {
        guard let errorCode = AuthErrorCode.Code(rawValue: error._code) else {
            return "Ocorreu um erro ao redefinir a senha. Por favor, tente novamente mais tarde."
        }

        switch errorCode {
        case .invalidEmail:
            return "O e-mail fornecido é inválido."
        case .userNotFound:
            return "Não existe uma conta associada a esse e-mail."
        case .userDisabled:
            return "Essa conta foi desativada."
        default:
            return "Ocorreu um erro ao redefinir a senha. Por favor, tente novamente mais tarde."
        }
    }
}
