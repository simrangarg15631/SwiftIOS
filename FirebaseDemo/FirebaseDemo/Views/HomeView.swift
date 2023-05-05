//
//  HomeView.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 10/04/23.
//

import SwiftUI
import GoogleSignInSwift

struct HomeView: View {
    @StateObject var homevm = HomeViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack{
            NavigationLink{
                SignInEmailView(showSignInView: $showSignInView)
            }label: {
                Text(K.Strings.signInWithEmail)
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .padding()
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)){
                Task{
                    do{
                        try await homevm.signInGoggle()
                        showSignInView = false
                    } catch{
                        print(error)
                    }
                }
            }
            .cornerRadius(5)
            .padding()
            
            Spacer()
        }
        .navigationTitle(K.Strings.signIn)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView(showSignInView: Binding.constant(false))
        }
    }
}
