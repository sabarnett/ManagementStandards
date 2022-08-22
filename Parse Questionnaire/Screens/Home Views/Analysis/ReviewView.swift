// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ReviewView: View {
    
    @EnvironmentObject var viewModel: AppData
    @State var appearAnimationActive: Bool = false
    @State var showDeletePrompt: Bool = false
    @State var selectedReviewId: UUID? = nil
    
    var body: some View {
        VStack {
            PageTitleView(title: "Reviews")
                .padding(.top, 15)
            
            if viewModel.reviewCount == 0 {
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
            } else {
                ZStack {
                    if viewModel.loadingReviews {
                        BusyView(caption: "retrieving reviews")
                    }
                    List(selection: $selectedReviewId) {
                        ForEach(viewModel.reviews) { review in
                            NavigationLink(destination: {
                                ReviewTabView(selectedReview: review)
                            }, label: {
                                ReviewViewCell(review: review)
                            })
                        }
                        .onDelete(perform: deleteReview)
                    }.listStyle(.plain)
                    .onAppear(perform: {
                        guard let selectedReview = viewModel.selectedReview else { return }
                        selectedReviewId = selectedReview.id
                    })
                }
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
        .alert(isPresented: $showDeletePrompt) { deleteReviewPrompt() }
    }
    
    fileprivate func deleteReview(at offsets: IndexSet) {
        viewModel.selectedReview = viewModel.reviews[offsets.first!]
        showDeletePrompt = true
    }
    
    fileprivate func deleteReviewPrompt() -> Alert {
        return Alert(
            title: Text("Are you sure?"),
            message: Text("Do you want to delete review:  '\(viewModel.selectedReview!.title)'? This action cannot be undone!"),
            primaryButton: .destructive(Text("Delete")) {
                    if let selectedReview = viewModel.selectedReview {
                        viewModel.deleteReview(selectedReview)
                    }
                    showDeletePrompt = false
                },
            secondaryButton: .cancel(Text("Keep")) {
                    showDeletePrompt = false
                }
        )
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
            .environmentObject(AppData())
    }
}
