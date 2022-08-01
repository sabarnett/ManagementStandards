// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct HomeTabView: View {
    
    @StateObject var viewModel : HomeTabViewModel = HomeTabViewModel()
    @State var showQuestionnaire: Bool = false
    
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
        }.sheet(isPresented: $showQuestionnaire) {
            QuestionnaireView(viewModel: viewModel, showQuestionnaire: $showQuestionnaire)
                .onDisappear() {
                    // They closed the questionnaire view
                    print("Questionnaire has disappeared")
                }
        }
    }
    
    // MARK:- Home page
    
    func homeTabs() -> some View {
        return TabView {
            ReviewView(viewModel: viewModel)
                .tabItem {
                    Label("Analyses", systemImage: "newspaper.fill")
                }

            AccountView()
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
            viewModel.loggedInUser = ""
        } label: {
            Text("Signout")
        }
    }
    
    private func homeTrailingBarItems() -> some View {
        HStack(spacing: 15) {
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
        HStack(spacing: 15) {
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
        }
        
    }

}

struct HomeNavView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
        
    }
}
