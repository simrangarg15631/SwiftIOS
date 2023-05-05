//
//  ButtonView.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 04/05/23.
//

import SwiftUI

struct ButtonLabelView: View {
    
    var label: String
    
    var body: some View {
        
        Text(label)
            .font(.headline)
            .padding(.vertical, 15)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(20)
    }
}

struct ButtonLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabelView(label: String())
    }
}
