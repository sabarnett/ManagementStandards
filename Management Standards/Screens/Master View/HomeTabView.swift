// Project: Management Standards
//
//  The master view (on the iPad) that displays the tool bar for additional
//  functions and the navigation bar icons. The content of the view is
//  provided by the ReviewView view.
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

            // This will appear as the detail page on the iPad. It gives us the
            // chance to give the users some instruction when the app first
            // opens and nothing has been selected from the review list.
            ReviewTabView(selectedReviewId: .constant(nil),
                    selectedReview: nil)
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
    
    // MARK: - Top of page tools
    
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
    
    // MARK: - Bottom of page tools
    
    private func toolbarItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Spacer()
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
