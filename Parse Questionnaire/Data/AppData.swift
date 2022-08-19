// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class AppData: ObservableObject {
    
    // MARK:- Review data model components
    
    @Published var reviews: [Review]!
    @Published var loadingReviews: Bool = true
    @Published var showReview: Bool = false
    var selectedReview: Review?
    
    /// Returns the number of reviews that the current user has associated with them.
    var reviewCount: Int {
        if let reviews = reviews { return reviews.count }
        return 0
    }
    
    /// Loads the reviews for the currently logged in user. If there is no logged in user, then
    /// the review list will be initialised to an empty list.
    func loadReviews() {
        if let currentUser = Users.shared.loggedInUser {
            reviews = Reviews.shared.get(forUser: currentUser.name)
        } else {
            reviews = []
        }
        loadingReviews = false
    }
    
    /// Saves the current review list for the currently logged in user. If there s=is no logged in user, then
    /// nothing will be saved.
    func saveReviews() {
        guard let currentUser = Users.shared.loggedInUser else { return }
        Reviews.shared.save(reviews, forUser: currentUser.name)
    }
    
    /// Adds a review to the review list. Thge review will be added to the top of the list, so it
    /// appears at the top in the UI.
    ///
    /// - Parameter review: The review to be added.
    func addReview(_ review: Review) {
        if reviewCount == 0 {
            reviews = []
        }
        
        reviews.insert(review, at: 0)
        saveReviews()
    }
    
    /// Deletes a review from the current list. A check is made to ensure that the review exists before we
    /// try to delete it, but no exception will be thrown if it is not found. Once the review has been removed,
    /// the list of reviews will be saved to disc.
    ///
    /// - Parameter reviewToDelete: The review to be deleted
    func deleteReview(_ reviewToDelete: Review) {
        if let deleteIndex = reviews.firstIndex(where: { review in review.id == reviewToDelete.id }) {
            reviews.remove(at: deleteIndex)
            saveReviews()
        }
    }
    
    /// Deletes the account for the currently logged in user. The user will be deleted from the users list and
    /// any reviews they have will be deleted.
    /// 
    func deleteAccount() {
        guard let currentUser = Users.shared.loggedInUser else { return }
        Users.shared.remove(userName: currentUser.name)
    }
}
