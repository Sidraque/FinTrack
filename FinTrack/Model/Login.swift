//
//  Login.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 18/06/23.
//

import Foundation

struct LoginModel {
    var email: String
    var password: String
    
    func validateLogin() -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        let isEmailValid = emailPredicate.evaluate(with: email)
        let isPasswordValid = password.count >= 6
        
        return isEmailValid && isPasswordValid
    }
}
