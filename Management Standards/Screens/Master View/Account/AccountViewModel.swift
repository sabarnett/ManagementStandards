// Project: Management Standards

import Foundation

class AccountViewModel: ObservableObject {
    
    @Published var username: String
    
    @Published var firstname: String
    @Published var lastname: String
    @Published var email: String

    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var verifyPassword: String = ""
    
    @Published var messageItem: MessageItem?

    init() {
        let user = Users.shared.loggedInUser
        
        username = user?.name ?? ""
        firstname = user?.firstname ?? ""
        lastname = user?.lastname ?? ""
        email = user?.email ?? ""
    }
    
    func updateUser() {
        // Verify data
        if firstname.trimmingCharacters(in: .whitespaces).isEmpty {
            messageItem = MessageContext.firstnameRequired
            return
        }
        if lastname.trimmingCharacters(in: .whitespaces).isEmpty {
            messageItem = MessageContext.lastnameRequired
            return
        }
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            messageItem = MessageContext.emailRequired
            return
        }

        // Update user
        Users.shared.updateLoggedInUser(firstname: firstname,
                                        lastname: lastname,
                                        email: email)
        
        // inform the user
        messageItem = MessageContext.userUpdated
    }
    
    func updatePassword() {
        // Verify data
        if oldPassword.trimmingCharacters(in: .whitespaces).isEmpty {
            messageItem = MessageContext.oldPasswordRequired
            return
        }
        if newPassword.trimmingCharacters(in: .whitespaces).isEmpty {
            messageItem = MessageContext.newPasswordRequired
            return
        }
        if verifyPassword.trimmingCharacters(in: .whitespaces).isEmpty {
            messageItem = MessageContext.verifyPasswordRequired
            return
        }
        if newPassword != verifyPassword {
            messageItem = MessageContext.newPasswordsDoNotMatch
            return
        }

        if !Auth.validatePassword(oldPassword, forUser: Users.shared.loggedInUser!) {
            messageItem = MessageContext.oldPasswordIncorrect
            return
        }
        
        // Update password
        Users.shared.updateLoggedInPassword(newPassword: Auth.encrypt(newPassword))
        
        // Reset the data entry fields.
        oldPassword = ""
        newPassword = ""
        verifyPassword = ""
        
        // Save user
        messageItem = MessageContext.passwordUpdated
    }
}
