//
//  RowView.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 29/03/23.
//

import SwiftUI

struct BoxView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var imageName: String = "Apple Health"
    var name: String = "Apple Health"
    var text: String = "Steps, Floors, Glasses"
    
    @State private var isOn = false
    
    var body: some View {
        HStack{
            
            Image(imageName)
                .resizable()
                .frame(width:30, height: 30)
            
            
            VStack(alignment: .leading){
                Text(name.localized(language))
                    .font(.headline)
                Text(text.localized(language))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .scaledToFit()
            
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(5)
        .shadow(color:Color.gray, radius:1)
    }
}

struct Box_Previews: PreviewProvider {
    static var previews: some View {
        BoxView()
    }
}
