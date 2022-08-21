// Project: Parse Questionnaire
//
//  
//

import Foundation

struct UserList: Codable {
    var users: [User]
}

class User: Codable, Identifiable {
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()

        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        self.firstname = try container.decodeIfPresent(String.self, forKey: .firstname) ?? ""
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname) ?? ""
        self.jobtitle = try container.decodeIfPresent(String.self, forKey: .jobtitle) ?? ""

        self.created = try container.decodeIfPresent(Date.self, forKey: .created) ?? Date.now
        self.updated = try container.decodeIfPresent(Date.self, forKey: .updated) ?? Date.now
        
        self.preferences = try container.decodeIfPresent(UserPreferences.self, forKey: .preferences) ??
            UserPreferences(
                qaCardFilter: .unitResults
            )
    }
    
    // Identifiable protocol
    var id: UUID = UUID()
    
    // User definition
    var name: String
    var email: String?
    var password: String
    var firstname: String?
    var lastname: String?
    var jobtitle: String?
    
    // Housekeeping
    var created: Date = Date.now
    var updated: Date = Date.now
    
    // User preferences
    var preferences: UserPreferences = UserPreferences(
        qaCardFilter: .allResults
    )
}


struct UserPreferences: Codable {
    var qaCardFilter: qaCardFilterResults
}

enum qaCardFilterResults: Int, CaseIterable, Codable {
    case allResults
    case unitResults
}

