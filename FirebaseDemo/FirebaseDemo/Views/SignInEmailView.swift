//
//  SignInEmailView.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 10/04/23.
//

import SwiftUI

struct SignInEmailView: View {
    
    @StateObject var viewModel = SignInEmailViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{ 
            TextField(K.Strings.email, text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField(K.Strings.password, text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .padding(.bottom, 20)
             
            Button{
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignInView = false
                        return //If we hit return we will never go to the next do catch block means user signup
                    }catch{
                        print(error.localizedDescription)
                    }
                    //If we dont hit return means user is already created and needs to signIn
                    do{
                        try await viewModel.signIn()
                        showSignInView = false
                        return //If we hit return we will never go to the next do catch block means user signup
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }label: {
                Text(K.Strings.signIn)
                    .foregroundColor(.white)
                    .padding(10)
            }
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle(K.Strings.signInWithEmail)
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignInEmailView(showSignInView: Binding.constant(false))
        }
    }
}
