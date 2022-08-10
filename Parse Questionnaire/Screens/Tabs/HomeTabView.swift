// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct HomeTabView: View {
    
    @StateObject var viewModel : HomeTabViewModel
    @State var showQuestionnaire: Bool = false
    @State var showInfoView: Bool = false
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationView {
            if viewModel.showReview {
                reviewTabs()

            } else {
                homeTabs()
                    .transition(.scale)
                    .zIndex(2) // to keep the views on top, however this needs to be changed when the active child view changes.
            }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .sheet(isPresented: $showQuestionnaire) {
            QuestionnaireView(viewModel: viewModel, showQuestionnaire: $showQuestionnaire)
                .onDisappear() {
                    // They closed the questionnaire view
                    print("Questionnaire has disappeared")
                }
        }
        .sheet(isPresented: $showInfoView) {
            InfoView(showInfoView: $showInfoView)
        }
    }
    
    // MARK:- Home page
    
    func homeTabs() -> some View {
        return TabView {
            ReviewView(viewModel: viewModel)
                .tabItem {
                    Label("Analyses", systemImage: "newspaper.fill")
                }

            AccountView(viewModel: viewModel, loggedIn: $loggedIn)
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: homeLeadingBarItems()
                            , trailing: homeTrailingBarItems())
        
    }
    
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
                // TODO: Handle adding a questionnaire
                showQuestionnaire = true
            } label: {
                Image(systemName: "plus")
            }
            Button {
                // TODO: Handle settings
            } label: {
                Image(systemName: "gearshape")
            }
            Button {
                showInfoView = true
            } label: {
                Image(systemName: "info.circle")
            }
        }
        
    }
    
    // MARK:- Review details page
    
    func reviewTabs() -> some View {
        return TabView {
            ResultUnitsView(review: viewModel.selectedReview!)
                .tabItem { Label("Units", systemImage: "list.bullet.rectangle.portrait") }

            ResultsQA(review: viewModel.selectedReview!)
                .tabItem { Label("Q&A", systemImage: "questionmark.app") }

            ResultsReport(review: viewModel.selectedReview!)
                .tabItem { Label("Report", systemImage: "doc.plaintext") }
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: reviewLeadingBarItems()
                            , trailing: reviewTrailingBarItems())

    }
    
    private func reviewLeadingBarItems() -> some View {
        Button { viewModel.showReview = false  }
        label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Reviews")
            }
        }
            
    }
    
    private func reviewTrailingBarItems() -> some View {
        HStack(spacing: 10) {
//            Button {
//                // TODO: Handle adding a questionnaire
//                showQuestionnaire = true
//            } label: {
//                Image(systemName: "plus")
//            }
//            Button {
//                // TODO: Handle settings
//            } label: {
//                Image(systemName: "gearshape")
//            }
            Button {
                showInfoView = true
            } label: {
                Image(systemName: "info.circle")
            }

        }
        
    }

}

struct HomeNavView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(viewModel: HomeTabViewModel(), loggedIn: .constant(true))
    }
}
