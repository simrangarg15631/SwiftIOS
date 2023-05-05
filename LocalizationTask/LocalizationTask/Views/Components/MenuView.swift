//
//  MenuView.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 30/03/23.
//

import SwiftUI

struct MenuView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @State private var text = "Select"
    var btn1 = "kg/cm"
    var btn2 = "lbs/inch"
    
    var body: some View {
        HStack{
            Text(text.localized(language))
                .foregroundColor(.secondary)
            Spacer()
            Menu {
                Button {
                    text = btn1
                } label: {
                    Text(btn1.localized(language))
                    
                }
                Button {
                    text = btn2
                } label: {
                    Text(btn2.localized(language))
                }
            } label: {
                
            Image(systemName: "chevron.down")
                    .foregroundColor(.black)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .shadow(color:Color.gray, radius:1)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
