// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class Reviews {
    public static let shared = Reviews()
    
    private init() { }
    
    private var reviewList: ReviewList!
    
    /// Retrieve the list of reviews associated with a user
    ///
    /// - Parameter forUser: The login name of the user we want the reviews for
    ///
    /// - Returns: A list of review objects. The list may be empty if there are no reviews
    ///
    func get(forUser: String) -> [Review] {
        loadReviewList(forUser: forUser)
        return reviewList.reviews
    }
    
    /// Saves the review list we have been passed for the user. The list will be persisted to disk.
    ///
    /// - Parameters:
    ///   - reviews: An array of Review objects to be saved
    ///   - forUser: The login user name to save the reviews to
    ///
    func save(_ reviews: [Review], forUser: String) {
        reviewList.reviews = reviews
        saveReviewsList(forUser: forUser)
    }
    
    /// Remove the user review file. This is the file containing the review data and has the
    /// file name <username>-ReviewList. It is in the same folder as the user list.
    ///
    /// - Parameter userName: The name of the user that we want to remove the reviews for
    ///
    func remove(forUser userName: String) {
        let reviewsFileURL = reviewsFileName(userName: userName)
        if FileManager.default.fileExists(atPath: reviewsFileURL.absoluteString) {
            do {
                try FileManager.default.removeItem(atPath: reviewsFileURL.absoluteString)
            } catch {}
        }
    }

    func newReview() -> Review {
        Review(created: Date.now,
                title: "",
                description: "",
                QA: [],
                units: [])
    }
    
    // Mark: - Load/save review list
    
    private func loadReviewList(forUser: String) {
        // Find and load the user list. If it doesn't exist, create it
        let fileURL = reviewsFileName(userName: forUser)
        
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
        let fileURL = reviewsFileName(userName: forUser)
        
        do {
            let data = try JSONEncoder().encode(reviewList)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save data")
        }
    }

    
    /// Generate the file name from which we will load or to which we will save the reviews for the user
    ///
    /// - Parameter userName: The login name of the user
    /// 
    /// - Returns: The file URL of the reviews file. Note; for a new user, the file **may** not exist
    ///
    private func reviewsFileName(userName: String) -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return URL(fileURLWithPath: "\(userName)-ReviewList", relativeTo: directoryURL)
            .appendingPathExtension("json")
    }
}
