// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ReviewView: View {
    
    @StateObject var viewModel: HomeTabViewModel
    @State var appearAnimationActive: Bool = false
    
    var body: some View {
        VStack {
            PageTitleView(title: "Reviews")
            
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
                    List(viewModel.reviews) { datum in
                        ReviewViewCell(review: datum)
                            .onTapGesture {
                                viewModel.selectedReview = datum
                                viewModel.showReview = true
                            }
                    }.listStyle(.plain)
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
        .onDisappear {
            appearAnimationActive = false
        }

    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(viewModel: HomeTabViewModel())
    }
}
