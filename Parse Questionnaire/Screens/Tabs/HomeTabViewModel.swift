// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class HomeTabViewModel: ObservableObject {
    
    @Published var currentUser: User!
    
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
        reviews = Reviews.shared.get(forUser: currentUser.name)
        loadingReviews = false
    }

    func saveReviews() {
        Reviews.shared.save(reviews, forUser: currentUser.name)
    }
    
    func addReview(_ review: Review) {
        if reviewCount == 0 {
            reviews = []
        }
        
        reviews.insert(review, at: 0)
        saveReviews()
    }
}
