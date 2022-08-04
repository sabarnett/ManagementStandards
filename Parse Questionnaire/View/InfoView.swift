// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct InfoView: View {
    
    @Binding var showInfoView: Bool
    
    var body: some View {
        ZStack {
            PopupBackgroundView()
            
            VStack {
                Text("App Info View")
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                showInfoView = false
            } label: { XDismissButton() }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(showInfoView: .constant(true))
    }
}
