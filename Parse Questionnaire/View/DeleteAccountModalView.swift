// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct DeleteAccountModalView: View {
    
    @StateObject var viewModel: HomeTabViewModel
    @Binding var showWarning: Bool
    @Binding var loggedIn: Bool

    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "exclamationmark.octagon.fill")
                    .frame(width: 120, height: 120)
                    .scaleEffect(6)
                Text("STOP!")
                    .font(.title)
                Text("If you delete your account, all of your reviews will be deleted from the system. You will not be able to login using this user name again.")
                Text("This action cannot be reversed!")
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()
                
                Button(action: {
                    showWarning = false
                }, label: {
                    APPButtonText(caption: "Keep Account!",
                        buttonWidth: 220)
                }).padding(.bottom, 20)
                
                Button(action: {
                    viewModel.deleteAccount()
                    loggedIn = false
                    showWarning = false
                }, label: {
                    APPButtonText(caption: "Delete Account!",
                        buttonWidth: 220,
                        backgroundColor: Color(.systemRed),
                        foregroundColor: Color.white)
                })
                
                Spacer()
            }.foregroundColor(Color(.systemRed))
                .padding(20)
        }
    }
}

struct DeleteAccountModalView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountModalView(
            viewModel: HomeTabViewModel(),
            showWarning: .constant(true),
            loggedIn: .constant(true)
        )
    }
}
