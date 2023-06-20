//
//  RegisterView.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func registerButtonTapped(name: String, email: String, password: String, birthday: String, gender: String)
    func loginScreenButtonTapped()
}

class RegisterView: UIView {
    weak var delegate: RegisterViewDelegate?

    private let scrollView: UIScrollView
    private let contentView: UIView

    private let nameTextField: UITextField
    private let emailTextField: UITextField
    private let passwordTextField: UITextField
    private let registerButton: UIButton
    private let loginButton: UIButton
    private let customGenderTextField: UITextField
    private let genderPickerView: UIPickerView
    private let genderOptions = ["Masculino", "Feminino", "Outro", "Prefiro não dizer"]
    private let logoImageView: UIImageView
    private let birthdayTextField: UITextField

    init() {
        scrollView = UIScrollView()
        contentView = UIView()

        nameTextField = UITextField()
        emailTextField = UITextField()
        passwordTextField = UITextField()
        registerButton = UIButton()
        loginButton = UIButton()
        customGenderTextField = UITextField()
        genderPickerView = UIPickerView()
        logoImageView = UIImageView()
        birthdayTextField = UITextField()

        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)

        backgroundColor = UIColor.white

        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)

        // Content View
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        // Logo
        logoImageView.image = UIImage(named: "FinTrack-Logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoImageView)

        // Name TextField
        nameTextField.placeholder = "Nome"
        nameTextField.textColor = UIColor.black
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.cornerRadius = 15
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameTextField)

        // Email TextField
        emailTextField.placeholder = "Email"
        emailTextField.textColor = UIColor.black
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.cornerRadius = 15
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailTextField)

        // Password TextField
        passwordTextField.placeholder = "Senha"
        passwordTextField.textColor = UIColor.black
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(passwordTextField)

        // Configurar customGenderTextField
        customGenderTextField.placeholder = "Digite seu gênero"
        customGenderTextField.borderStyle = .roundedRect
        customGenderTextField.layer.cornerRadius = 15
        customGenderTextField.font = UIFont.systemFont(ofSize: 16)
        customGenderTextField.isHidden = true
        customGenderTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customGenderTextField)

        // Birthday TextField
        birthdayTextField.placeholder = "Data de Nascimento"
        birthdayTextField.textColor = UIColor.black
        birthdayTextField.borderStyle = .roundedRect
        birthdayTextField.layer.cornerRadius = 15
        birthdayTextField.font = UIFont.systemFont(ofSize: 16)
        birthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(birthdayTextField)

        // inputAccessoryView
        let inputAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 110))
        inputAccessoryView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
        inputAccessoryView.layer.cornerRadius = 40

        // UIDatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.layer.cornerRadius = 40
        inputAccessoryView.addSubview(datePicker)

        datePicker.centerXAnchor.constraint(equalTo: inputAccessoryView.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: inputAccessoryView.centerYAnchor).isActive = true

        birthdayTextField.inputAccessoryView = inputAccessoryView

        // Remover o teclado do birthdayTextField
        birthdayTextField.inputView = UIView()

        //genderPickerView
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(genderPickerView)

        // Register Button
        registerButton.setTitle("Cadastrar", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = UIColor.systemGreen
        registerButton.layer.cornerRadius = 28
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(registerButton)

        // Login Button
        let attributedText = NSMutableAttributedString(string: "Já tem conta? ", attributes: [.foregroundColor: UIColor.gray])
        attributedText.append(NSAttributedString(string: "Login", attributes: [.foregroundColor: UIColor.systemGreen]))
        loginButton.setAttributedTitle(attributedText, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginButton)

        // Actions for buttons
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginScreenButtonTapped), for: .touchUpInside)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Content View
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Logo
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -55),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 290),
            logoImageView.heightAnchor.constraint(equalToConstant: 290),

            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -65),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),

            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            // Birthday TextField
            birthdayTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            birthdayTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            birthdayTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 50),

            // Gender Picker View
            genderPickerView.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 20),
            genderPickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            genderPickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            genderPickerView.heightAnchor.constraint(equalToConstant: 60),

            // Custom Gender Text Field
            customGenderTextField.topAnchor.constraint(equalTo: genderPickerView.bottomAnchor, constant: 7),
            customGenderTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            customGenderTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            customGenderTextField.heightAnchor.constraint(equalToConstant: 50),

            // Register Button
            registerButton.topAnchor.constraint(equalTo: customGenderTextField.bottomAnchor, constant: 15),
            registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 55),

            // Login Button
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 8),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func handleTap() {
        self.endEditing(true)
    }

    @objc private func registerButtonTapped() {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let birthday = birthdayTextField.text,
              let gender = customGenderTextField.isHidden ? genderOptions[genderPickerView.selectedRow(inComponent: 0)] : customGenderTextField.text else {
                  return
              }

        delegate?.registerButtonTapped(name: name, email: email, password: password, birthday: birthday, gender: gender)
    }

    @objc private func loginScreenButtonTapped() {
        delegate?.loginScreenButtonTapped()
    }

    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        birthdayTextField.text = DateFormatter.birthdayFormatter.string(from: sender.date)
    }
    
}

extension RegisterView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedGender = genderOptions[row]
        if selectedGender == "Outro" {
            customGenderTextField.isHidden = false
        } else {
            customGenderTextField.isHidden = true
            customGenderTextField.text = ""
        }
    }
}

extension DateFormatter {
    static let birthdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}
