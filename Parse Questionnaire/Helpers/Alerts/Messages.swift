// Project: Parse Questionnaire
//
//  
//

import SwiftUI

enum MessageResponse {
    case Primary
    case Secondary
    case Dismiss
}

struct MessageButton {
    let type: MessageResponse
    var caption: String
    var color: Color = Color.buttonBackground
}

struct MessageItem: Identifiable {
    
    init(title: String, message: String, dismissButton: String, dismissButtonColor: Color = .buttonBackground) {
        self.title = title
        self.message = message
        self.dismissButton.caption = dismissButton
    }
    
    init(title: String, message: String, primaryButton: String, secondaryButton: String,
         primaryButtonColor: Color = Color(UIColor.systemRed), secondaryButtonColor: Color = Color(UIColor.systemBlue)) {
        self.title = title
        self.message = message
        
        self.primaryButton.caption = primaryButton
        self.primaryButton.color = primaryButtonColor
        
        self.secondaryButton.caption = secondaryButton
        self.secondaryButton.color = secondaryButtonColor
    }
    
    let id = UUID()
    var title: String
    var message: String
    var dismissButton: MessageButton = MessageButton(type: .Dismiss, caption: "", color: .buttonBackground)
    var primaryButton: MessageButton = MessageButton(type: .Primary, caption: "", color: Color(UIColor.systemRed))
    var secondaryButton: MessageButton = MessageButton(type: .Secondary, caption: "", color: Color(UIColor.systemBlue))
}

struct MessageContext {
    // MARK: - Login and registration alerts
    static let invalidCredentials = MessageItem(title: "Invalid Login",
                                                message: "There was a problem with the usrername/password you entered. Please try again",
                                                dismissButton: "OK")
    
    static let userAlreadyExists = MessageItem(title: "Registration Failure",
                                               message: "The user name you entered already exists. Please pick another one",
                                               dismissButton: "OK")
    
    static let userNameRequired = MessageItem(title: "Invalid Entry",
                                              message: "You must enter the user name.",
                                              dismissButton: "OK")
    
    static let passwordRequired = MessageItem(title: "Invalid Entry",
                                              message: "You must enter the password.",
                                              dismissButton: "OK")
    
    // MARK: - Questionnaore messages
    
    static let reviewTitleRequired = MessageItem(title: "Invalid Entry",
                                                 message: "You must enter a review title.",
                                                 dismissButton: "OK")
    
    static let reviewDescriptionRequired = MessageItem(title: "Invalid Entry",
                                                       message: "You must enter a review description.",
                                                       dismissButton: "OK")
    
    static let confirmQuit = MessageItem(title: "Are you sure you want to cancel?",
                                         message: "If you close the questionnaire now, your answers will be discarded and the analysis will not be created.",
                                         primaryButton: "Quit",
                                         secondaryButton: "Resume")
    
    // MARK: - User details page - User Details
    
    static let firstnameRequired = MessageItem(title: "Invalid Entry",
                                               message: "You must enter a first name.",
                                               dismissButton: "OK")
    
    static let lastnameRequired = MessageItem(title: "Invalid Entry",
                                              message: "You must enter a last name.",
                                              dismissButton: "OK")
    
    static let emailRequired = MessageItem(title: "Invalid Entry",
                                           message: "You must enter an email address.",
                                           dismissButton: "OK")
    
    static let userUpdated = MessageItem(title: "Updated",
                                         message: "Your user details have been saved.",
                                         dismissButton: "OK")
    
    // MARK: - User details page - Password Change
    
    static let oldPasswordRequired = MessageItem(title: "Invalid Entry",
                                                 message: "You must enter your current password.",
                                                 dismissButton: "OK")
    
    static let oldPasswordIncorrect = MessageItem(title: "Invalid Entry",
                                                  message: "The current password you entered is not correct.",
                                                  dismissButton: "OK")
    
    static let newPasswordRequired = MessageItem(title: "Invalid Entry",
                                                 message: "You must enter your new password.",
                                                 dismissButton: "OK")
    
    static let verifyPasswordRequired = MessageItem(title: "Invalid Entry",
                                                    message: "You must enter your new password again.",
                                                    dismissButton: "OK")
    
    static let newPasswordsDoNotMatch = MessageItem(title: "Invalid Entry",
                                                    message: "You new password and the verification password do not match.",
                                                    dismissButton: "OK")
    
    static let passwordUpdated = MessageItem(title: "Updated",
                                             message: "Your password has been updated.",
                                             dismissButton: "OK")
    
    // MARK: - Review list actions
    static let deleteReviewPrompt = MessageItem(title: "Delete Review?",
                                                message: "Are you sure you want to delete review ??. This acrion cannot be undone!",
                                                primaryButton: "Delete",
                                                secondaryButton: "Keep"
    )
}
