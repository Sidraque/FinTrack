//
//  ForgotPasswordView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 14/06/23.
//

import UIKit

protocol ForgotPasswordViewDelegate: AnyObject {
    func resetPasswordButtonTapped(email: String)
    func backButtonTapped()
}

class ForgotPasswordView: UIView {

    weak var delegate: ForgotPasswordViewDelegate?

    private let emailTextField: UITextField
    private let resetPasswordButton: UIButton
    private let backButton: UIButton
    private let logoImageView: UIImageView

    override init(frame: CGRect) {
        emailTextField = UITextField()
        resetPasswordButton = UIButton()
        backButton = UIButton()
        logoImageView = UIImageView()

        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        // Logo
        logoImageView.image = UIImage(named: "FinTrack-Forgot")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImageView)

        // Email TextField
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.cornerRadius = 15
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailTextField)

        // Reset Password Button
        resetPasswordButton.setTitle("Redefinir Senha", for: .normal)
        resetPasswordButton.setTitleColor(.white, for: .normal)
        resetPasswordButton.backgroundColor = .systemGreen
        resetPasswordButton.layer.cornerRadius = 28
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(resetPasswordButton)

        // Back Button
        backButton.setTitle("Voltar", for: .normal)
        backButton.setTitleColor(.gray, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)

        // Configure actions for buttons
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Configure constraints
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Logo
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),

            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            // Reset Password Button
            resetPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            resetPasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            resetPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),

            // Back Button
            backButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: 20),
            backButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    @objc private func resetPasswordButtonTapped() {
        guard let email = emailTextField.text else {
            return
        }

        delegate?.resetPasswordButtonTapped(email: email)
    }

    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
}
