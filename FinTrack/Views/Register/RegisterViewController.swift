//
//  RegisterViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController {
    private var registerView: RegisterView!
    private var viewModel: RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegisterView()
        setupViewModel()
        
        navigationItem.hidesBackButton = true
    }
    
    private func setupRegisterView() {
        registerView = RegisterView()
        registerView.delegate = self
        registerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerView)
        
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.topAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel = RegisterViewModel()
        viewModel.delegate = self
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func registerButtonTapped(name: String, email: String, password: String, birthday: String, gender: String) {
        let registerModel = RegisterModel(name: name, email: email, password: password, birthday: birthday, gender: gender)
        viewModel.registerUser(with: registerModel)
    }

    func loginScreenButtonTapped() {
        let loginViewController = LoginViewController()
        loginViewController.isEmailVerificationRequired = false
        navigationController?.pushViewController(loginViewController, animated: true)
    }

    private func navigateToLoginScreen() {
        let loginViewController = LoginViewController()
        loginViewController.isEmailVerificationRequired = true
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func registrationSuccess() {
        // Registration success logic
        let alert = UIAlertController(title: "Cadastro realizado", message: "Seu cadastro foi realizado com sucesso! Verifique seu e-mail para ativar sua conta.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Redirecionar o usuário para a tela de login
            self.navigateToLoginScreen()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func registrationFailure(error: Error) {
        // Registration failure logic
        print("Erro ao criar o usuário: \(error.localizedDescription)")
        // Display an error message to the user
    }
}
