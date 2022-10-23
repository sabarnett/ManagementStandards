// Project: Management Standards
//
//  Displays the review detail view. From here, we get to the list of units,
//  the question/answer analysis and the full report.
//

import SwiftUI

struct ReviewTabView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel : AppData
    
    @Binding var selectedReviewId: UUID?

    @State var selectedReview: Review?
    @State var showInfoView: Bool = false
    @State private var reportItems: ActivityItem?
    
    var body: some View {
        if selectedReview == nil || viewModel.reviewCount == 0 {
            // This will appear as the detail page on the iPad. It gives us the
            // chance to give the users some instruction when the app first
            // opens and nothing has been selected from the review list.
            VStack {
                Spacer()
                
                Image("StarPages")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 280, alignment: .center)
                    .padding(.top, 20)
                Text("Please expand the sidebar and select a review from the reviews list, or press the + icon to create a new one.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 400)
                Spacer()
            }
        } else {
            TabView {
                ResultUnitsView(review: selectedReview!)
                    .tabItem { Label("Units", systemImage: "list.bullet.rectangle.portrait") }
                
                ResultsQA(review: selectedReview!)
                    .tabItem { Label("Q&A", systemImage: "questionmark.app") }
                
                ResultsReport(review: selectedReview!)
                    .tabItem { Label("Report", systemImage: "doc.plaintext") }
            }
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: reviewLeadingBarItems(),
                                trailing: reviewTrailingBarItems(selectedReview: selectedReview!))
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal, 20)
            .padding(.top, 15)
            
            .onAppear {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                
                selectedReviewId = selectedReview?.id
            }
            .sheet(isPresented: $showInfoView) {
                InfoView(showInfoView: $showInfoView)
            }
        }
    }
    
    // MARK: - Back button.

    // The back button is only appropriate for the iPhone style device. If this is
    // and iPad, then we don't need it as we will have master/detail views shown
    // at the same time.
    private func reviewLeadingBarItems() -> some View {
        Button { presentationMode.wrappedValue.dismiss()  }
        label: {
            HStack {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    EmptyView()
                } else {
                    Image(systemName: "chevron.left").padding(.trailing, 0)
                    Text("Reviews")
                }
            }
        }
    }
    
    // MARK: - Share button

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
        }
    }
}

struct ReviewTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTabView(selectedReviewId: .constant(UUID()),
                      selectedReview: Review.dummyData)
    }
}
