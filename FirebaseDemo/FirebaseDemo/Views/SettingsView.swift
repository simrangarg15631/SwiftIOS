//
//  SettingsView.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 10/04/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        List{
            Button(K.Strings.logOut){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    }catch{
                        print(error)
                    }
                }
            }
            
            if viewModel.authProviders.contains(.email) {
                EmailSectionView(viewModel: viewModel)
            }
            
        }
        .onAppear{
            viewModel.loadProviders()
        }
        .navigationTitle(K.Strings.settings)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationStack{
            SettingsView(showSignInView: .constant(false))
        }
    }
}
