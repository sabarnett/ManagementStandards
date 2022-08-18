// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var viewModel: AppData
    @Binding var loggedIn: Bool

    @StateObject var accViewModel: AccountViewModel = AccountViewModel()
    @State var appearAnimationActive:Bool = false
    @State var showDeleteAccountVerification: Bool = false
    
    var body: some View {
        VStack {
            PageTitleView(title: "Your Details",
                          subtitle: accViewModel.username)
            
            Form {
                Section(header: Text("Your Details").bold()) {
                    TextInput(field: "First Name", text: $accViewModel.firstname)
                    TextInput(field: "Last Name", text: $accViewModel.lastname)
                    TextInput(field: "Email Address", text: $accViewModel.email)
                        .keyboardType(.emailAddress)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            hideKeyboard()
                            accViewModel.updateUser()
                        }, label: { Text("Update")})
                    }
                }
                
                Section(header: Text("Password Change").bold()) {
                    TextInput(field: "Old Password", text: $accViewModel.oldPassword, secure: true)
                    TextInput(field: "New Password", text: $accViewModel.newPassword, secure: true)
                    TextInput(field: "Repeat Password", text: $accViewModel.verifyPassword, secure: true)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            hideKeyboard()
                            accViewModel.updatePassword()
                        }, label: { Text("Update")})
                    }
                }
                
                Section(header: Text("Delete Account").bold()) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showDeleteAccountVerification.toggle()
                        }, label: {
                            APPButtonText(caption: "Delete Account!",
                                          buttonWidth: 220,
                                          backgroundColor: Color(.systemRed),
                                          foregroundColor: Color.white)
                        })
                        .fullScreenCover(
                            isPresented: $showDeleteAccountVerification,
                            content: {
                                DeleteAccountModalView(
                                    showWarning: $showDeleteAccountVerification,
                                    loggedIn: $loggedIn)
                            })
                        
                        Spacer()
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
        .alert(item: $accViewModel.alertItem) {
            alertItem in
            
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.dismissButton))
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(loggedIn: .constant(true))
        .environmentObject(AppData())
            .preferredColorScheme(.dark)
    }
}

struct TextInput: View {
    
    var field: String
    @Binding var text: String
    var secure: Bool = false
    
    var body: some View {
        if secure {
            SecureField(field, text: $text)
                .foregroundColor(.primary)
                .padding(8)
                .background(.tertiary)
                .cornerRadius(8.0)
        } else {
            TextField(field, text: $text)
                .foregroundColor(.primary)
                .padding(8)
                .background(.tertiary)
                .cornerRadius(8.0)
        }
    }
}
