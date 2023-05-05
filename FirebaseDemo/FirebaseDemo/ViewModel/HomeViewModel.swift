//
//  HomeViewModel.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 11/04/23.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject{
    
    func signInGoggle() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
