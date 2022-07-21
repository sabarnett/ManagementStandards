// Project: Parse Questionnaire
//
//  
//

import Foundation

struct Unit: Identifiable, Codable {
    var id: String
    var analysisText: String
    
    static var empty: Unit {
        Unit(id: "", analysisText: "")
    }
    
    static var dummyData: Unit {
        Unit(id: "A1", analysisText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
    }
}
