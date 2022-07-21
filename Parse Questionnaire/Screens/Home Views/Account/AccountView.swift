// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct AccountView: View {
    
    @State var appearAnimationActive:Bool = false
    
    var body: some View {
        VStack {
            Text("Account View")
            Text("Account View")
            Text("Account View")
            Text("Account View")
            Text("Account View")
            Text("Account View")
            Text("Account View")
            Text("Account View")
            Text("Account View")
            Text("Account View")
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
