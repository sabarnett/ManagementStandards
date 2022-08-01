// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class Reviews {
    public static let shared = Reviews()
    
    private init() { }
    
    private var reviewList: ReviewList!
    
    func get(forUser: String) -> [Review] {
        loadReviewList(forUser: forUser)
        return reviewList.reviews
//        // Find the reviews file.
//        // If it doesn't exist, return an empty list
//        // Else return the loaded reviews
//        [Review.dummyData, Review.dummyData, Review.dummyData]
    }
    
    func save(_ reviews: [Review], forUser: String) {
        reviewList.reviews = reviews
        saveReviewsList(forUser: forUser)
    }
    
    // Mark:- Load/save user list
    private func loadReviewList(forUser: String) {
        // Find and load the user list. If it doesn't exist, create it
        let fileURL = Reviews.reviewsFileName(userName: forUser)
        
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: fileURL)
            
            // Decode the data file
            reviewList = try JSONDecoder().decode(ReviewList.self, from: savedData)
        } catch {
            // Assume file not found, create dummy file
            reviewList = ReviewList(reviews: [])
        }
    }

    private func saveReviewsList(forUser: String) {
        let fileURL = Reviews.reviewsFileName(userName: forUser)
        
        do {
            let data = try JSONEncoder().encode(reviewList)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save data")
        }
    }

    
    public static func reviewsFileName(userName: String) -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return URL(fileURLWithPath: "\(userName)-ReviewList", relativeTo: directoryURL)
            .appendingPathExtension("json")
    }
}
