//
//  ActionButtonView.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 17/04/23.
//

import SwiftUI

struct ActionButtonView: View {

    var imageName = Key.Images.envelope
    var btn = Key.Strings.mail
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .frame(width: 120, height: 60)
            
            VStack(spacing: 6){
                Image(systemName: imageName)
                    .foregroundColor(.gray).opacity(0.4)
                    .font(.title2)
                Text(btn)
                    .font(.caption)
                    .foregroundColor(.gray).opacity(0.4)
            }
        }
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView()
    }
}
