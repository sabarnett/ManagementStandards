// Project: Management Standards
//
//  
//

import Foundation

struct QandA: Codable, Identifiable {
    
    // MARK: - Q and A Persistable properties.
    
    var id: Int                 // Question Number
    var question: String
    var answer: String
    var units: String
}

extension QandA {
    
    // MARK: - Q and A Persistable properties.
    
    func unitText(unitText: [Unit]) -> [Unit] {
        guard !units.isEmpty else { return [] }
        
        let unitList = units.components(separatedBy: CharacterSet(charactersIn: "&,"))
        let result = unitList.map({ unit -> Unit in
            let trimmedUnit = unit.trimmingCharacters(in: CharacterSet([" "]))
            return unitText.first(where: { $0.id == trimmedUnit })!
        })
        return result
    }
}
