// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class SigninViewModel: ObservableObject {
    
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var alertItem: AlertItem?
    
    @AppStorage("loggedInUser") var loggedInUser: String = ""

    func signin() {
        if !validateForm() { return }
        
        // Signin - validate the user and the password
        guard let user = Users.shared.get(userName: userName) else {
            alertItem = AlertContext.invalidCredentials
            return
        }
        
        if !Auth.validatePassword(password, forUser: user) {
            alertItem = AlertContext.invalidCredentials
            return
        }
        
        loggedInUser = user.name
    }
    
    func register() {
        if !validateForm() { return }

        // TODO: Register - check the user does not exist and add it if it does.
        if Users.shared.get(userName: userName) != nil {
            alertItem = AlertContext.userAlreadyExists
            return
        }
        
        let newUser = User(name: userName, email: "", password: Auth.encrypt(password))
        Users.shared.save(newUser)
        
        loggedInUser = newUser.name
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
