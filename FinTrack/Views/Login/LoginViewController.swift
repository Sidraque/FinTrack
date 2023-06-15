//
//  LoginViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
    private var loginView: LoginView!
    private var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(frame: view.bounds)
        loginView.delegate = self
        view = loginView
        
        viewModel = LoginViewModel()
        navigationItem.hidesBackButton = true
    }
    
    func loginButtonTapped(email: String, password: String) {
        viewModel.email = email
        viewModel.password = password
        
        if viewModel.validateLogin() {
            let homeViewController = HomeViewController()
            navigationController?.pushViewController(homeViewController, animated: true)
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
}

