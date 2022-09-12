// Project: Parse Questionnaire
//
//  Defines the properties of a unit
//

import Foundation

struct Unit: Identifiable, Codable {
    var id: String
    var title: String
    var analysisText: String
    
    var sortKey: String {
        // Unit id isa single letter followed by a variable number of
        // numbers. This leads to some odd sort orders, so we provide this
        // computed property to translate the unit id into a single letter
        // plus a fixed three digit number with leading zeros.
        let number = "000\(id.dropFirst(1))"        
        return "\(id.prefix(1))\(number.suffix(3))"
    }
}
