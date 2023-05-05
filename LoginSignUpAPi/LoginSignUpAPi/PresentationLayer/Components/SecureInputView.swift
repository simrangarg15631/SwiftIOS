//
//  SecureInputView.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                } else {
                    TextField(title, text: $text)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                }
            }.padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ?  Key.Images.eyeSlash: Key.Images.eye)
                    .accentColor(.gray)
            }
        }
    }
}

struct SecureInputView_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputView(String(), text: Binding.constant(String()))
    }
}
