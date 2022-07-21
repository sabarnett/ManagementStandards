// Project: Parse Questionnaire
//
//  
//

import Foundation

struct UserList: Codable {
    var users: [User]
}

struct User: Codable, Identifiable {
    // Identifiable protocol
    var id: UUID = UUID()
    
    // User definition
    var name: String
    var email: String
    var password: String
    
    // Housekeeping
    var created: Date = Date.now
    var updated: Date = Date.now
    
    static func dummy() -> User {
        User(name: "Dummy", email: "dummy@dummy.com", password: Auth.encrypt("dummy"))
    }
}
