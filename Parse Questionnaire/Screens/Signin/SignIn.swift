// Project: Parse Questionnaire
//
//  All users are required to sign in to the system to view previous
//  reviews. If the user has not used the system before, they can tap
//  the register button to create a new user. When you register, the minimum
//  data is collected (username/password) and the user is automatically
//  logged in.
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
                if formIsValid() {
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
        .messageBox(message: $viewModel.messageItem)
    }
    
    func formIsValid() -> Bool {
        if !viewModel.usernameIsValid() {
            focusField = .userName
        } else if !viewModel.passwordIsValid() {
            focusField = .password
        } else {
            return true
        }
        return false
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
