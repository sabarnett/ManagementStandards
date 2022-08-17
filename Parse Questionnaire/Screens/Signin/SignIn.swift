// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct SignIn: View {
    
    private enum Field: Hashable {
        case userName
        case password
    }
    
    @FocusState private var focusField: Field?
    @StateObject var viewModel = SigninViewModel()
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack {
            Image("YesNoMaybe")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .padding(.bottom, 40)
            
            TextField("User Name", text: $viewModel.userName)
                .focused($focusField, equals: .userName)
                .foregroundColor(.primary)
                .padding()
                .background(.tertiary)
                .cornerRadius(8.0)
                .onAppear() {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){ focusField = .userName }
                }
            
            SecureField("Password", text: $viewModel.password)
                .focused($focusField, equals: .password)
                .foregroundColor(.primary)
                .padding()
                .background(.tertiary)
                .cornerRadius(8.0)
            
            Button {
                if viewModel.userName.isEmpty {
                    focusField = .userName
                } else if viewModel.password.isEmpty {
                    focusField = .password
                } else {
                    hideKeyboard()
                    if viewModel.signin() { loggedIn = true }
                }
            } label: {
                APPButtonText(caption: "Sign in", buttonWidth: 280)
            }.padding(.top, 20)
            
            Button {
                hideKeyboard()
                if viewModel.register() { loggedIn = true }
            } label: {
                Text("Register")
            }
        }
        .padding(30)
        .alert(item: $viewModel.alertItem) {
            alertItem in
            
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.dismissButton))
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(loggedIn: .constant(false))
            .preferredColorScheme(.dark)
    }
}
