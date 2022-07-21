// Project: Parse Questionnaire
//
//  
//

import SwiftUI

class HomeTabViewModel: ObservableObject {
    
    @AppStorage("loggedInUser") var loggedInUser: String = ""
    
    @Published var currentUser: User!
    
    init() {
        currentUser = Users.shared.get(userName: loggedInUser)
        if currentUser == nil { currentUser = User.dummy() }
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
    func  loadReviews() {
        reviews = Reviews.shared.get(forUser: loggedInUser)
        loadingReviews = false
    }

}
