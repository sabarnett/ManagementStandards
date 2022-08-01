// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class SigninViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var alertItem: AlertItem?
    
    /// Attempt to signin. The form will be validated first and them we will login the user
    /// if no issues are found
    ///
    /// - Returns: True if the sign in works, else false. If there was an error, the alertItem property
    /// will be set with the error details.
    func signin() -> Bool {
        if !validateForm() { return false }

        // Attempt to login. This will either retrieve the user details or
        // quietly fail and sdet the current user to nil.
        Users.shared.signin(userName: userName)

        // Signin - validate the user and the password
        guard let user = Users.shared.loggedInUser else {
            alertItem = AlertContext.invalidCredentials
            return false
        }
        
        if !Auth.validatePassword(password, forUser: user) {
            alertItem = AlertContext.invalidCredentials
            return false
        }
        
        return true
    }
    
    /// Attempt to register a new user. The form will be validated first and a check will be made to ensure that the
    /// user name has not been previously registered. If the registration completes, the user will be signed in.
    ///
    /// - Returns: True if the user is registered, else false. If there was an error, the alertItem
    /// will be set with the specific error details.
    func register() -> Bool {
        if !validateForm() { return false }

        if Users.shared.get(userName: userName) != nil {
            alertItem = AlertContext.userAlreadyExists
            return false
        }
        
        let newUser = User(name: userName, email: "", password: Auth.encrypt(password))
        Users.shared.save(newUser)
        
        Users.shared.signin(userName: userName)
        return true
    }
    
    // MARK:- Local helper functions
    
    fileprivate func validateForm() -> Bool {
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
