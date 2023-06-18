//
//  ForgotPasswordViewModel.swift
//  FinTrack
//
//  Created by Sidraque Agostinho on 18/06/23.
//

import Foundation
import Firebase

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func resetPasswordSuccess()
    func resetPasswordFailure(error: Error)
}

class ForgotPasswordViewModel {
    weak var delegate: ForgotPasswordViewModelDelegate?

    func resetPassword(with model: ForgotPasswordModel) {
        Auth.auth().sendPasswordReset(withEmail: model.email) { [weak self] error in
            if let error = error {
                self?.delegate?.resetPasswordFailure(error: error)
            } else {
                self?.delegate?.resetPasswordSuccess()
            }
        }
    }
}
