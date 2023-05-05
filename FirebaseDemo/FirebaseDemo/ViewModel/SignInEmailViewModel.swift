//
//  SignInEmailViewModel.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 10/04/23.
//

import Foundation

@MainActor //Read about it
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            //do email password validations here
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
        print("Success")
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            //do email password validations here
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
        print("Success")
    }
}
