// Project: Parse Questionnaire
//
//  
//

import SwiftUI

@main
struct Parse_QuestionnaireApp: App {
    
    @State var loggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !loggedIn {
                SignIn(loggedIn: $loggedIn)
            } else {
                HomeTabView(viewModel: HomeTabViewModel(), loggedIn: $loggedIn)
            }
        }
    }
}
