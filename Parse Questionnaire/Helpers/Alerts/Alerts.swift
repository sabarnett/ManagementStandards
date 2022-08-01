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
}
