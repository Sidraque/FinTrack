//
//  RegisterViewController.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

class RegisterViewController: UIViewController {
    private var registerView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegisterView()
        
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
}

extension RegisterViewController: RegisterViewDelegate {
    func registerButtonTapped(name: String, email: String, password: String) {
        // Implemente o código para tratar o evento de cadastro aqui
        // Você pode usar as informações de nome, email e senha que foram passadas como parâmetros
    }
    
    func loginScreenButtonTapped() {
        let loginViewController = LoginViewController()
        // Configurar a transição de apresentação, por exemplo, empilhando na navegação ou apresentando modally
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}
