// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class HomeTabViewModel: ObservableObject {
    
    @Published var currentUser: User?
    
    init() {
        currentUser = Users.shared.loggedInUser
    }
    
    // MARK:- Review data model components
    
    @Published var reviews: [Review]!
    @Published var loadingReviews: Bool = true
    @Published var showReview: Bool = false
    var selectedReview: Review?
    
    var reviewCount: Int {
        if let reviews = reviews { return reviews.count }
        return 0
    }
    
    func loadReviews() {
        if let currentUser = currentUser {
            reviews = Reviews.shared.get(forUser: currentUser.name)
        } else {
            reviews = []
        }
        loadingReviews = false
    }

    func saveReviews() {
        guard let currentUser = currentUser else { return }
        Reviews.shared.save(reviews, forUser: currentUser.name)
    }
    
    func addReview(_ review: Review) {
        if reviewCount == 0 {
            reviews = []
        }
        
        reviews.insert(review, at: 0)
        saveReviews()
    }
    
    func deleteReview(_ reviewToDelete: Review) {
        if let deleteIndex = reviews.firstIndex(where: { review in review.id == reviewToDelete.id }) {
            reviews.remove(at: deleteIndex)
            saveReviews()
        }
    }
    
    func deleteAccount() {
        guard let currentUser = currentUser else { return }
        Users.shared.remove(userName: currentUser.name)
    }
}
