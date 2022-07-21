// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ResultsReport: View {
    
    @State var review: Review
    @State var appearAnimationActive:Bool = false

    var body: some View {
        VStack {
            Text("Report Page")
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
    }
}
