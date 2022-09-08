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

                .toolbar {
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
            
            VStack {
                Spacer()
                
                Image("StarPages")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 280, alignment: .center)
                Text("Please expand the sidebar and select a review from the reviews list, or press the + icon to create a new one.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 400)
                Spacer()
            }
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
