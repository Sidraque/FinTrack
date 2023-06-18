//
//  RegisterViewModel.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 18/06/23.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol RegisterViewModelDelegate: AnyObject {
    func registrationSuccess()
    func registrationFailure(error: Error)
}

class RegisterViewModel {
    weak var delegate: RegisterViewModelDelegate?

    private var db: Firestore
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }

    func registerUser(with model: RegisterModel) {
        Auth.auth().createUser(withEmail: model.email, password: model.password) { [weak self] (authResult, error) in
            if let error = error {
                // Error creating user
                self?.delegate?.registrationFailure(error: error)
            } else {
                // Success
                guard let userID = authResult?.user.uid else {
                    return
                }

                let userData: [String: Any] = [
                    "name": model.name,
                    "email": model.email,
                    "birthday": model.birthday,
                    "gender": model.gender
                ]

                self?.db.collection("users").document(userID).setData(userData) { error in
                    if let error = error {
                        self?.delegate?.registrationFailure(error: error)
                    } else {
                        // Send verification email
                        authResult?.user.sendEmailVerification(completion: { (error) in
                            if let error = error {
                                self?.delegate?.registrationFailure(error: error)
                            } else {
                                self?.delegate?.registrationSuccess()
                            }
                        })
                    }
                }
            }
        }
    }
}
