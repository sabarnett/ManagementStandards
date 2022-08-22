// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ReviewTabView: View {
    
    @EnvironmentObject var viewModel : AppData
    @State var selectedReview: Review
    @State var showInfoView: Bool = false
    @State private var reportItems: ActivityItem?
    
    var body: some View {
        TabView {
            ResultUnitsView(review: selectedReview)
                .tabItem { Label("Units", systemImage: "list.bullet.rectangle.portrait") }

            ResultsQA(review: selectedReview)
                .tabItem { Label("Q&A", systemImage: "questionmark.app") }

            ResultsReport(review: selectedReview)
                .tabItem { Label("Report", systemImage: "doc.plaintext") }
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(/* leading: reviewLeadingBarItems(), */
            trailing: reviewTrailingBarItems(selectedReview: selectedReview))
        .padding(.horizontal, 20)
        .padding(.top, 15)

        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .sheet(isPresented: $showInfoView) {
            InfoView(showInfoView: $showInfoView)
        }
    }
    
    // MARK:- Review details page

//    private func reviewLeadingBarItems() -> some View {
//        Button { viewModel.showReview = false  }
//        label: {
//            HStack {
//                Image(systemName: "chevron.left")
//                Text("Reviews")
//            }
//        }
//    }
    
    private func reviewTrailingBarItems(selectedReview: Review) -> some View {
        HStack(spacing: 10) {
            Button {
                let reportData = selectedReview.reportShareItems()
                reportItems = ActivityItem (itemsArray: reportData)
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaleEffect(0.9)
            }
            .activitySheet($reportItems)
            
            Button {
                showInfoView = true
            } label: {
                Image(systemName: "info.circle")
            }
        }
    }

}

struct ReviewTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTabView(selectedReview: Review.dummyData)
    }
}
