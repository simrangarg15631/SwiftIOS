//
//  LanguageMenu.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 30/03/23.
//

import SwiftUI

struct LanguageMenu: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var body: some View {
        Menu {
            Button {
                LocalizationService.shared.language = .arabic
            } label: {
                Text("عربي")
                
            }
            Button {
                LocalizationService.shared.language = .english
            } label: {
                Text("English")

            }
            Button {
                LocalizationService.shared.language = .hindi
            } label: {
                Text("हिंदी")

            }
        } label: {
            if language == .english{
                Text("English")
                    .foregroundColor(Color.orange)
                    .font(.subheadline)
            }
            else if language == .arabic{
                Text("عربي")
                    .foregroundColor(Color.orange)
                    .font(.subheadline)
            }
            else if language == .hindi{
                Text("हिंदी")
                    .foregroundColor(Color.orange)
                    .font(.subheadline)
            }
        }
        .padding(.bottom, 10)
    }
}

struct LanguageMenu_Previews: PreviewProvider {
    static var previews: some View {
        LanguageMenu()
    }
}
