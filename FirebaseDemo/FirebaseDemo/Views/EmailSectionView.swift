//
//  EmailSectionView.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 11/04/23.
//

import SwiftUI

struct EmailSectionView: View {
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        Section(content: {
            Button(K.Strings.resetPassword){
                Task{
                    do{
                        try await viewModel.resetPassword()
                        print(K.Strings.resetPassword)
                    }catch{
                        print(error)
                    }
                }
            }
            Button(K.Strings.updatePassword){
                Task{
                    do{
                        try await viewModel.updatePassword()
                        print(K.Strings.updatePassword)
                    }catch{
                        print(error)
                    }
                }
            }
            Button(K.Strings.updateEmail){
                Task{
                    do{
                        try await viewModel.updateEmail()
                        print(K.Strings.updateEmail)
                    }catch{
                        print(error)
                    }
                }
            }

        }, header: {
            Text("Email Operations")
        })
    }
}

struct EmailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSectionView(viewModel: SettingsViewModel())
    }
}
