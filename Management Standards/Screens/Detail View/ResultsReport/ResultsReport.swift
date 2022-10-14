// Project: Management Standards
//
//  
//

import SwiftUI
import MarkdownUI

struct ResultsReport: View {
    
    @State var review: Review
    @State var appearAnimationActive:Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                PageTitleView(title: review.title)
                Spacer()
            }.padding(.top, 0)
            
            Text(review.description)
                .font(.body)
            
            ScrollView(showsIndicators: false) {
                MarkdownView(markdown: review.report)
            }
        }
        .opacity(appearAnimationActive ? 1 : 0.1)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                appearAnimationActive = true
            }
        }
        .onDisappear {
            appearAnimationActive = false
        }
    }
}

struct ResultsReport_Previews: PreviewProvider {
    static var previews: some View {
        ResultsReport(review: Review.dummyData)
            .preferredColorScheme(.dark)
    }
}
