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
            viewModel.loginUser { [weak self] result in
                switch result {
                case .success(let user):
                    if user.isEmailVerified {
                        let homeViewController = HomeViewController()
                        self?.navigationController?.pushViewController(homeViewController, animated: true)
                    } else {
                        let alert = UIAlertController(title: "E-mail não verificado", message: "Você precisa verificar seu e-mail antes de fazer login. Deseja reenviar o e-mail de verificação?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
                            self?.sendEmailVerification()
                        }))
                        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print("Erro de autenticação: \(error.localizedDescription)")
                    if let errorCode = AuthErrorCode.Code(rawValue: error._code) {
                        switch errorCode {
                        case .wrongPassword:
                            let alert = UIAlertController(title: "Erro de autenticação", message: "Senha incorreta. Verifique sua senha e tente novamente.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self?.present(alert, animated: true, completion: nil)
                        default:
                            let alert = UIAlertController(title: "Erro de autenticação", message: "Email ou senha incorretos. Verifique suas credenciais e tente novamente.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self?.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Erro de autenticação", message: "Email ou senha incorretos. Verifique suas credenciais e tente novamente.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            print("Erro de validação")
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
        viewModel.sendEmailVerification { [weak self] result in
            switch result {
            case .success:
                let alert = UIAlertController(title: "E-mail enviado", message: "Um e-mail de verificação foi enviado para o seu endereço de e-mail. Verifique sua caixa de entrada e clique no link fornecido para verificar seu e-mail.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self?.present(alert, animated: true, completion: nil)
            case .failure(let error):
            print("Erro ao enviar e-mail de verificação: (error.localizedDescription)")
            }
        }
    }
}
