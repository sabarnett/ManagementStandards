// Project: Management Standards
//
//  Displays a progress bar while the review list loads.
//

import SwiftUI

struct BusyView: View {
    
    var caption: String?
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
            VStack(spacing: 20) {
                ProgressView().tint(.gray).scaleEffect(2)
                
                if let caption = caption {
                    Text(caption).font(.title2).foregroundColor(.gray)
                }
            }
        }
    }
}

struct BusyView_Previews: PreviewProvider {
    static var previews: some View {
        BusyView(caption: "Test")
    }
}
