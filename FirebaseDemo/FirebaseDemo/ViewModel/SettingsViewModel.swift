//
//  SettingsViewModel.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 10/04/23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject{
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadProviders(){
        if let providers = try? AuthenticationManager.shared.getProvider() {
            authProviders = providers
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws{
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "test123@chicmic.co.in"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "12345678"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}
