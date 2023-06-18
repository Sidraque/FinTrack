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
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                // Exibir mensagem de erro ao redefinir a senha
                let alertController = UIAlertController(title: "Erro", message: self.getErrorMessage(for: error), preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            // Exibir mensagem de sucesso
            let alertController = UIAlertController(title: "Redefinição de senha enviada", message: "Um e-mail com as instruções para redefinir a senha foi enviado para o endereço fornecido.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
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

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

