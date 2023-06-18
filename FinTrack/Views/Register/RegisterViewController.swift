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
    private var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegisterView()
        setupFirestore()
        
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
    
    private func setupFirestore() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func registerButtonTapped(name: String, email: String, password: String, birthday: String, gender: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Erro ao criar o usuário
                print("Erro ao criar o usuário: \(error.localizedDescription)")
            } else {
                // Sucesso
                print("Usuário criado com sucesso!")

                // Salvar os dados adicionais do usuário no Firestore
                guard let userID = authResult?.user.uid else {
                    return
                }

                let userData: [String: Any] = [
                    "name": name,
                    "email": email,
                    "birthday": birthday,
                    "gender": gender
                ]

                self.db.collection("users").document(userID).setData(userData) { error in
                    if let error = error {
                        print("Erro ao salvar os dados adicionais do usuário: \(error.localizedDescription)")
                    } else {
                        print("Dados adicionais do usuário salvos com sucesso!")

                        // Enviar e-mail de verificação
                        authResult?.user.sendEmailVerification(completion: { (error) in
                            if let error = error {
                                print("Erro ao enviar e-mail de verificação: \(error.localizedDescription)")
                            } else {
                                print("E-mail de verificação enviado com sucesso!")
                            }
                        })

                        // Exibir mensagem de sucesso
                        let alert = UIAlertController(title: "Cadastro realizado", message: "Seu cadastro foi realizado com sucesso! Verifique seu e-mail para ativar sua conta.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            // Redirecionar o usuário para a tela de login
                            self.navigateToLoginScreen()
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
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

