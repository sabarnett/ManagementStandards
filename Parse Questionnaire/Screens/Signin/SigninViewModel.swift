// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class SigninViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var alertItem: AlertItem?

    func signin() {
        if !validateForm() { return }

        // Attempt to login. This will either retrieve the user details or
        // quietly fail and sdet the current user to nil.
        Users.shared.signin(userName: userName)

        // Signin - validate the user and the password
        guard let user = Users.shared.loggedInUser else {
            alertItem = AlertContext.invalidCredentials
            return
        }
        
        if !Auth.validatePassword(password, forUser: user) {
            alertItem = AlertContext.invalidCredentials
            return
        }
        
    }
    
    func register() {
        if !validateForm() { return }

        if Users.shared.get(userName: userName) != nil {
            alertItem = AlertContext.userAlreadyExists
            return
        }
        
        let newUser = User(name: userName, email: "", password: Auth.encrypt(password))
        Users.shared.save(newUser)
        
        Users.shared.signin(userName: userName)
    }
    
    private func validateForm() -> Bool {
        if userName == "" {
            alertItem = AlertContext.userNameRequired
            return false
        }
        if password == "" {
            alertItem = AlertContext.passwordRequired
            return false
        }

        return true
    }
}
