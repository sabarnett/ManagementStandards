// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ResultsQA: View {

    enum filterResults: Int, CaseIterable {
        case allResults
        case unitResults
    }
    
    @State var review: Review
    @State var appearAnimationActive:Bool = false
    @State private var selection: Int = 0
    @AppStorage("FilterQAResults") var filterQAResults: filterResults = .allResults
    
    var body: some View {
        VStack {
            PageTitleView(title: "Q and A")
            
            HStack {
                Spacer()
                Menu() {
                    Text("Filter results to show")
                    Button(action: {
                        selection = 0
                        filterQAResults = .allResults
                    }, label: {
                        if filterQAResults == .allResults {
                            Image(systemName: "checkmark").padding(.trailing, 3)
                        }
                        Text("All Q & A")
                    })
                    Button(action: {
                        selection = 0
                        filterQAResults = .unitResults
                    }, label: {
                        if filterQAResults == .unitResults {
                            Image(systemName: "checkmark").padding(.trailing, 3)
                        }
                        Text("Questions with units")
                    })
                } label: {
                    Image(systemName: filterQAResults == .allResults ? "menucard" : "menucard.fill")
                        .scaleEffect(1.6)
                }
            }.padding(.horizontal)
            
            TabView(selection: $selection) {
                ForEach(filteredQA()) {
                    q in
                    ResultsQACard(qa: q, units: review.units)
                        .tag(q.id)
                }
            }.tabViewStyle(.page)
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
    
    func filteredQA() -> [QandA] {
        let values = review.QA.filter {
            q in
            
            if filterQAResults == .allResults { return true }
            return !q.units.isEmpty
        }
        return values
    }
}

struct ResultsQA_Previews: PreviewProvider {
    static var previews: some View {
        ResultsQA(review: Review.dummyData)
    }
}
