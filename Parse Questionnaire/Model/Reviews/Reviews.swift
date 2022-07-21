// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class Reviews {
    public static let shared = Reviews()
    
    private init() { }
    
    func get(forUser: String) -> [Review] {
        // Find the reviews file.
        // If it doesn't exist, return an empty list
        // Else return the loaded reviews
        [Review.dummyData, Review.dummyData, Review.dummyData]
    }
}
