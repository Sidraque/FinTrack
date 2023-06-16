//
//  LoginViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, LoginViewDelegate {
    private var loginView: LoginView!
    private var viewModel: LoginViewModel!
    
    var isEmailVerificationRequired = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(frame: view.bounds)
        loginView.delegate = self
        view = loginView
        
        viewModel = LoginViewModel()
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isEmailVerificationRequired {
            loginView.emailVerificationLabel.isHidden = false
        } else {
            loginView.emailVerificationLabel.isHidden = true
        }
    }
    
    func loginButtonTapped(email: String, password: String) {
        viewModel.email = email
        viewModel.password = password
        
        if viewModel.validateLogin() {
            if isEmailVerificationRequired {
                let alert = UIAlertController(title: "E-mail não verificado", message: "Você precisa verificar seu e-mail antes de fazer login. Deseja reenviar o e-mail de verificação?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
                    self.sendEmailVerification()
                }))
                alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let homeViewController = HomeViewController()
                navigationController?.pushViewController(homeViewController, animated: true)
            }
        } else {
            // Exibir mensagem de erro
        }
    }
    
    func forgotPasswordScreenButtonTapped() {
        let forgotPasswordViewController = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    func registerScreenButtonTapped() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    private func sendEmailVerification() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        user.sendEmailVerification { (error) in
            if let error = error {
                print("Erro ao enviar e-mail de verificação: \(error.localizedDescription)")
                return
            }
            
            let alert = UIAlertController(title: "E-mail enviado", message: "Um e-mail de verificação foi enviado para o seu endereço de e-mail. Verifique sua caixa de entrada e clique no link fornecido para verificar seu e-mail.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
