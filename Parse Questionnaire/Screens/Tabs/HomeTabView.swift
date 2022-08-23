// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct HomeTabView: View {
    
    @EnvironmentObject var viewModel : AppData
    @State var showQuestionnaire: Bool = false
    @State var showInfoView: Bool = false
    @State var showAccountView: Bool = false
    @State private var reportItems: ActivityItem?
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationView {
            ReviewView()
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: homeLeadingBarItems(),
                                    trailing: homeTrailingBarItems())
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .sheet(isPresented: $showQuestionnaire) {
            QuestionnaireView(showQuestionnaire: $showQuestionnaire)
        }
        .sheet(isPresented: $showInfoView) {
            InfoView(showInfoView: $showInfoView)
        }
        .sheet(isPresented: $showAccountView) {
            AccountView(loggedIn: $loggedIn)
        }
    }
    
    // MARK:- Home page
    
    private func homeLeadingBarItems() -> some View {
        Button {
            Users.shared.signout()
            loggedIn = false
        } label: {
            Text("Signout")
        }
    }
    
    private func homeTrailingBarItems() -> some View {
        HStack(spacing: 10) {
            Button {
                showQuestionnaire.toggle()
            } label: {
                Image(systemName: "plus")
            }
            Button {
                showAccountView.toggle()
            } label: {
                Image(systemName: "person")
            }
            Button {
                showInfoView.toggle()
            } label: {
                Image(systemName: "info.circle")
            }
        }
    }
}

struct HomeNavView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(loggedIn: .constant(true))
            .environmentObject(AppData())
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
