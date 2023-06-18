//
//  LoginView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func loginButtonTapped(email: String, password: String)
    func forgotPasswordScreenButtonTapped()
    func registerScreenButtonTapped()
}

class LoginView: UIView {
    weak var delegate: LoginViewDelegate?

    private let emailTextField: UITextField
    private let passwordTextField: UITextField
    private let loginButton: UIButton
    private let forgotPasswordButton: UIButton
    private let registerButton: UIButton
    private let logoImageView: UIImageView
    let emailVerificationLabel: UILabel
    
    override init(frame: CGRect) {
        emailTextField = UITextField()
        passwordTextField = UITextField()
        loginButton = UIButton()
        forgotPasswordButton = UIButton()
        registerButton = UIButton()
        logoImageView = UIImageView()
        emailVerificationLabel = UILabel()
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)

        // Configurar layout e adicionar subviews
        backgroundColor = UIColor.white
        
        // Logo
        logoImageView.image = UIImage(named: "FinTrack-Logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImageView)
        
        // Email TextField
        emailTextField.placeholder = "Email"
        emailTextField.textColor = UIColor.black
        emailTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 15
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.delegate = self
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailTextField)
        
        // Password TextField
        passwordTextField.placeholder = "Senha"
        passwordTextField.textColor = UIColor.black
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passwordTextField)
        
        // Login Button
        loginButton.setTitle("Entrar", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.systemGreen
        loginButton.layer.cornerRadius = 28
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginButton)
        
        // Forgot Password Button
        forgotPasswordButton.setTitle("Esqueci minha senha", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.gray, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(forgotPasswordButton)
        
        // Register Button
        registerButton.setTitle("Cadastre-se", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = UIColor.systemGreen
        registerButton.layer.cornerRadius = 28
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(registerButton)
        
        // Email Verification Label
        emailVerificationLabel.text = "Verifique seu e-mail antes de fazer login."
        emailVerificationLabel.textColor = UIColor.red
        emailVerificationLabel.textAlignment = .center
        emailVerificationLabel.numberOfLines = 0
        emailVerificationLabel.font = UIFont.systemFont(ofSize: 14)
        emailVerificationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailVerificationLabel)
        
        // Configurar ações dos botões
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Logo
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 290),
            logoImageView.heightAnchor.constraint(equalToConstant: 290),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -50),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            
            // Forgot Password Button
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 4),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            
            // Register Button
            registerButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 55),
            
            // Email Verification Label
            emailVerificationLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 7),
            emailVerificationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailVerificationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    @objc private func handleTap() {
        self.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        delegate?.loginButtonTapped(email: email, password: password)
    }
    
    @objc private func forgotPasswordButtonTapped() {
        delegate?.forgotPasswordScreenButtonTapped()
    }
    
    @objc private func registerButtonTapped() {
        delegate?.registerScreenButtonTapped()
    }
}

extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == emailTextField else {
            return true
        }
        
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        textField.text = updatedText.lowercased()
        
        return false
    }
}
