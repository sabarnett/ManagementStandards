// Project: Management Standards
//
//  App entry point. This is the place where we ensure that the user is logged in before
//  we allow access to the rest of the app.
//
//  We also create the first instance of the AppData structure, which will be passed to all
//  views via the EnvironmentObject mechanism. It contains the primary data components that
//  all child views will require.
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
