// Project: Parse Questionnaire
//
//  
//

import Foundation
import CryptoKit

struct Auth {
    
    /// Returns the encrypted password generated from the plain text password
    ///
    /// - Parameter password: The plain text password to encryopt
    ///
    /// - Returns: The encrypted password for the user object
    ///
    static func encrypt(_ password: String) -> String {
        let data = Data(password.utf8)
        let hashed = SHA256.hash(data: data)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashString
    }
    
    /// Checks that the plain text password we were passed is a match for the encrypted password
    /// in the user we are passed.
    /// - Parameters:
    ///   - password: The plain text password to validate
    ///
    ///   - user: The user object to check against
    ///
    /// - Returns: True if the passwor dis valid, else false.
    ///
    static func validatePassword(_ password: String, forUser user: User) -> Bool {
        let encryptedPassword = self.encrypt(password)
        return encryptedPassword == user.password
    }
}
