// Project: Parse Questionnaire
//
//  
//

import Foundation

class AccountViewModel: ObservableObject {
    
    @Published var username: String
    
    @Published var firstname: String
    @Published var lastname: String
    @Published var email: String

    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var verifyPassword: String = ""
    
    @Published var alertItem: AlertItem?

    init() {
        let user = Users.shared.loggedInUser
        
        username = user?.name ?? ""
        firstname = user?.firstname ?? ""
        lastname = user?.lastname ?? ""
        email = user?.email ?? ""
    }
    
    func updateUser() {
        // Verify data
        if firstname.isEmpty {
            alertItem = AlertContext.firstnameRequired
            return
        }
        if lastname.isEmpty {
            alertItem = AlertContext.lastnameRequired
            return
        }
        if email.isEmpty {
            alertItem = AlertContext.emailRequired
            return
        }

        // Update user
        Users.shared.updateLoggedInUser(firstname: firstname,
                                        lastname: lastname,
                                        email: email)
        
        // inform the user
        alertItem = AlertContext.userUpdated
    }
    
    func updatePassword() {
        // Verify data
        if oldPassword.isEmpty {
            alertItem = AlertContext.oldPasswordRequired
            return
        }
        if newPassword.isEmpty {
            alertItem = AlertContext.newPasswordRequired
            return
        }
        if verifyPassword.isEmpty {
            alertItem = AlertContext.verifyPasswordRequired
            return
        }
        if newPassword != verifyPassword {
            alertItem = AlertContext.newPasswordsDoNotMatch
            return
        }

        if !Auth.validatePassword(oldPassword, forUser: Users.shared.loggedInUser!) {
            alertItem = AlertContext.oldPasswordIncorrect
            return
        }
        
        // Update password
        Users.shared.updateLoggedInPassword(newPassword: Auth.encrypt(newPassword))
        
        // Reset the data entry fields.
        oldPassword = ""
        newPassword = ""
        verifyPassword = ""
        
        // Save user
        alertItem = AlertContext.passwordUpdated
    }
}
