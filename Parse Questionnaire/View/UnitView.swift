// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct UnitView: View {
    
    @State var unit: Unit
    @Binding var sheetShown: Bool
    
    var body: some View {
        ZStack {
            PopupBackgroundView()
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Unit \(unit.id)")
                    .font(.title)
                    .foregroundColor(.titleColor)
                
                ScrollView(showsIndicators: false) {
                    MarkdownView(markdown: unit.analysisText)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                }
            }.padding()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                sheetShown = false
            } label: {
                XDismissButton()
            }
        }
    }
}

struct UnitView_Previews: PreviewProvider {
    static var previews: some View {
        UnitView(unit: Unit.dummyData,
                 sheetShown: .constant(true))
    }
}
