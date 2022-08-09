// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel: AccountViewModel = AccountViewModel()
    @State var appearAnimationActive:Bool = false
    
    var body: some View {
        VStack {
            PageTitleView(title: "Your Details",
                          subtitle: viewModel.username)
            
            VStack {
                Form {
                    Section(header: Text("Your Details").bold()) {
                        TextField("First Name", text: $viewModel.firstname)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.tertiary)
                            .cornerRadius(8.0)
                        TextField("Last Name", text: $viewModel.lastname)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.tertiary)
                            .cornerRadius(8.0)
                        TextField("Email Address", text: $viewModel.email)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.tertiary)
                            .cornerRadius(8.0)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.updateUser()
                            }, label: { Text("Update")})
                        }
                    }
                    
                    Section(header: Text("Password Change").bold()) {
                        SecureField("Old Password", text: $viewModel.oldPassword)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.tertiary)
                            .cornerRadius(8.0)

                        SecureField("New Password", text: $viewModel.newPassword)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.tertiary)
                            .cornerRadius(8.0)

                        SecureField("Repeat Password", text: $viewModel.verifyPassword)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.tertiary)
                            .cornerRadius(8.0)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.updatePassword()
                            }, label: { Text("Update")})
                        }
                    }
                }
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
        .alert(item: $viewModel.alertItem) {
            alertItem in
            
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.dismissButton))
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .preferredColorScheme(.dark)
    }
}
