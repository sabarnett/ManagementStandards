// Project: Parse Questionnaire
//
// SignInViewModel - Handles the signin and registration of users. Signin will validate
// that the user exists and that the password entered hashes to the stored password.
//  
// Registration will validate the user name and password and ensures that the user name
// has not already been registered. If the checks pass, the user will be created and
// the user will login automatically.
//

import SwiftUI

class SigninViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var messageItem: MessageItem?
    
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
            messageItem = MessageContext.invalidCredentials
            return false
        }
        
        if !Auth.validatePassword(password, forUser: user) {
            messageItem = MessageContext.invalidCredentials
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
            messageItem = MessageContext.userAlreadyExists
            return false
        }
        
        let newUser = User(name: userName, email: "", password: Auth.encrypt(password))
        Users.shared.save(newUser)
        
        Users.shared.signin(userName: userName)
        return true
    }
    
    // MARK: - Publically available validation functions
    
    /// Validates the current user name field.
    /// - Returns: Returns True if the field is valid, else False
    func usernameIsValid() -> Bool {
        if userName == "" { return false }
        return true
    }
    
    /// Validates that the password field is valid.
    /// - Returns: Returns True if valid, else false.
    func passwordIsValid() -> Bool {
        if password == "" { return false }
        return true
    }

    // MARK:- Local helper functions
    
    fileprivate func validateForm() -> Bool {
        if !usernameIsValid() {
            messageItem = MessageContext.userNameRequired
            return false
        }
        if !passwordIsValid() {
            messageItem = MessageContext.passwordRequired
            return false
        }

        return true
    }
}
