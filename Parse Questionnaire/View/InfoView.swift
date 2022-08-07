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
                Form {
                    Section(header: Text("About the App").bold()) {
                        AboutLineView(name: "Name", value: "Parse Questionnaire")
                        AboutLineView(name: "Version", value: "0.1.0")
                        AboutLineView(name: "Author", value: "Steven Barnett")
                    }
                    Section(header: Text("Support").bold()) {
                        AboutLineView(name: "Web", value: "http://www.sabarnett.co.uk")
                        AboutLineView(name: "Email", value: "mac@sabarnett.co.uk")
                    }
                    
                    VStack {
                        Image("YesNoMaybe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150, alignment: .center)
                            .opacity(0.6)
                        Text("Copyright (c) 2022 Steven Barnett")
                        Spacer()
                    }.padding(20)
                }
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
        Group {
            InfoView(showInfoView: .constant(true))
                .preferredColorScheme(.dark)
        }
    }
}

struct AboutLineView: View {
    
    let name: String
    let value: String
    
    var body: some View {
        HStack {
            Text(name).foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
}
