// Project: Parse Questionnaire
//
//  Displays the list of reviews that the user has previously created (or a
//  place holder if there are none). Tapping a review in the list displays the
//  detail view with the review contents.
//

import SwiftUI

struct ReviewView: View {
    
    @EnvironmentObject var viewModel: AppData
    @State var appearAnimationActive: Bool = false
    @State var showDeletePrompt: MessageItem? = nil
    
    var body: some View {
        VStack {
            PageTitleView(title: "Reviews")
                .padding(.top, 15)
            
            if viewModel.reviewCount == 0 {
                noReviewsView()
            } else {
                ZStack {
                    if viewModel.loadingReviews {
                        BusyView(caption: "retrieving reviews")
                    }
                    List(selection: $viewModel.selectedReviewId) {
                        ForEach(viewModel.reviews) { review in
                            
                            NavigationLink(
                                destination: ReviewTabView(selectedReview: review, selectedReviewId: $viewModel.selectedReviewId),
                                tag: review.id,
                                selection: $viewModel.selectedReviewId)
                                {
                                    ReviewViewCell(review: review)
                                }
                        }
                        .onDelete(perform: deleteReview)
                    }
                }
                .listStyle(.plain)
            }
        }
        .opacity(appearAnimationActive ? 1 : 0.1)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                appearAnimationActive = true
            }
            viewModel.loadReviews()
        }
        .onDisappear { appearAnimationActive = false }
        .messageBox(message: $showDeletePrompt) {
            response in
            
            if response == .Primary {
                if let selectedReview = viewModel.selectedReview {
                    viewModel.deleteReview(selectedReview)
                }
            }
        }
    }
    
    fileprivate func deleteReview(at offsets: IndexSet) {
        viewModel.selectedReview = viewModel.reviews[offsets.first!]
        
        var deleteMessage = MessageContext.deleteReviewPrompt
        deleteMessage.message = deleteMessage.message.replacingOccurrences(of: "$1", with: viewModel.selectedReview?.title ?? "")
        
        showDeletePrompt = deleteMessage
    }
    
    fileprivate func noReviewsView() -> some View {
        VStack {
            Spacer()
            
            Image("StarPages")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 280, alignment: .center)
            Text("You have not created any reviews. Please tap the + button to create your first one.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
            .environmentObject(AppData())
    }
}
