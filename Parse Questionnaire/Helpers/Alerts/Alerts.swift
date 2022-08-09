// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Text
}

struct AlertContext {
    // Mark: - Login and registration alerts
    static let invalidCredentials = AlertItem(title: Text("Invalid Login"),
                                           message: Text("There was a problem with the usrername/password you entered. Please try again"),
                                           dismissButton: Text("OK"))
    
    static let userAlreadyExists = AlertItem(title: Text("Registration Failure"),
                                           message: Text("The user name you entered already exists. Please pick another one"),
                                           dismissButton: Text("OK"))
    
    static let userNameRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter the user name."),
                                           dismissButton: Text("OK"))
    
    static let passwordRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter the password."),
                                           dismissButton: Text("OK"))
    
    static let reviewTitleRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter a review title."),
                                           dismissButton: Text("OK"))
    
    static let reviewDescriptionRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter a review description."),
                                           dismissButton: Text("OK"))
    
    static let firstnameRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter a first name."),
                                           dismissButton: Text("OK"))
    
    static let lastnameRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter a last name."),
                                           dismissButton: Text("OK"))
    
    static let emailRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter an email address."),
                                           dismissButton: Text("OK"))
    
    static let userUpdated = AlertItem(title: Text("Updated"),
                                           message: Text("Your user details have been saved."),
                                           dismissButton: Text("OK"))

    static let oldPasswordRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter your current password."),
                                           dismissButton: Text("OK"))

    static let oldPasswordIncorrect = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("The current password you entered is not correct."),
                                           dismissButton: Text("OK"))

    static let newPasswordRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter your new password."),
                                           dismissButton: Text("OK"))
    
    static let verifyPasswordRequired = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You must enter your new password again."),
                                           dismissButton: Text("OK"))
    
    static let newPasswordsDoNotMatch = AlertItem(title: Text("Invalid Entry"),
                                           message: Text("You new password and the verification password do not match."),
                                           dismissButton: Text("OK"))
    
    static let passwordUpdated = AlertItem(title: Text("Updated"),
                                           message: Text("Your password has been updated."),
                                           dismissButton: Text("OK"))
}
