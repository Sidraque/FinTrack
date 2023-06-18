//
//  LoginViewModel.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 13/06/23.
//

import Foundation
import Firebase

class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    func validateLogin() -> Bool {
        let model = LoginModel(email: email, password: password)
        return model.validateLogin()
    }
    
    func loginUser(completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = authResult?.user else {
                let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user"])
                completion(.failure(error))
                return
            }
            
            completion(.success(user))
        }
    }
    
    func sendEmailVerification(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in"])
            completion(.failure(error))
            return
        }
        
        user.sendEmailVerification { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
    }
}
