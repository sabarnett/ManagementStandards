// Project: Parse Questionnaire
//
//  
//

import SwiftUI

@main
struct Parse_QuestionnaireApp: App {
    
    @State var loggedIn: Bool = false
    
    var appData: AppData = AppData()
    
    var body: some Scene {
        WindowGroup {
            if !loggedIn {
                SignIn(loggedIn: $loggedIn)
            } else {
                HomeTabView(loggedIn: $loggedIn)
                    .environmentObject(appData)
            }
        }
    }
}
