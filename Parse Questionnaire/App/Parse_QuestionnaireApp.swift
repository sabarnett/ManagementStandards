// Project: Parse Questionnaire
//
//  
//

import SwiftUI

@objc class AppDelegate: NSObject, UIApplicationDelegate {

    @AppStorage("loggedInUser") var loggedInUser: String = ""

    func applicationWillTerminate(_ application: UIApplication) {
        print("Reset logged in user")
        loggedInUser = ""
    }
}

@main
struct Parse_QuestionnaireApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("loggedInUser") var loggedInUser: String = ""

//    init() {
//        Users.shared.remove(userName: "Fred")
//        Users.shared.remove(userName: "Fred2")
//        Users.shared.remove(userName: "Steve")

//        var steveUser = User(name: "Steve", email: "steve@sabarnett.co.uk", password: Auth.encrypt("pwd"))
//        Users.shared.save(steveUser)
//    }
    
    var body: some Scene {
        WindowGroup {
            if loggedInUser == "" {
                SignIn()
            } else {
                HomeTabView()
            }
        }
    }
}
