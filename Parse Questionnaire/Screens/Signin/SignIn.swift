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
                .frame(width: 160, height: 160, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .padding(.bottom, 30)
            
            TextField("User Name", text: $viewModel.userName)
                .submitLabel(.next)
                .focused($focusField, equals: .userName)
                .foregroundColor(.primary)
                .padding()
                .background(.tertiary)
                .cornerRadius(8.0)
                .frame(maxWidth: 420)
                .onSubmit {
                    focusField = .password
                }
            
            SecureField("Password", text: $viewModel.password)
                .submitLabel(.go)
                .focused($focusField, equals: .password)
                .foregroundColor(.primary)
                .padding()
                .background(.tertiary)
                .cornerRadius(8.0)
                .frame(maxWidth: 420)
                .onSubmit {
                    performSignin()
                }

            Button {
                if !viewModel.usernameIsValid() {
                    focusField = .userName
                } else if !viewModel.passwordIsValid() {
                    focusField = .password
                } else {
                    performSignin()
                }
            } label: {
                APPButtonText(caption: "Sign in", buttonWidth: 280)
            }.padding(.top, 20)
            
            Button {
                hideKeyboard()
                if viewModel.register() { loggedIn = true }
            } label: {
                Text("Register New User").font(.title3)
            }
        }
        .padding(20)
        .alert(item: $viewModel.alertItem) {
            alertItem in
            
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.dismissButton))
        }
    }
    
    func performSignin() {
        hideKeyboard()
        if viewModel.signin() { loggedIn = true }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(loggedIn: .constant(false))
            .preferredColorScheme(.dark)
    }
}
