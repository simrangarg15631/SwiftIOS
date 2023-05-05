//
//  AuthenticationMAnager.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 10/04/23.
//

import Foundation
import FirebaseAuth

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}


//Singleton Class
final class AuthenticationManager{
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func getProvider() throws -> [AuthProviderOption]{
        guard let providerData = Auth.auth().currentUser?.providerData else{
            throw URLError(.badServerResponse)
        }
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            }else{
                assertionFailure("Provider option not found")
            }
        }
        return providers
    }
    
    
    func signOut() throws{
        //signOut - resets the local authentication state. No call to the backend
        try Auth.auth().signOut()
    }
}

//MARK: Sign In Email Password
extension AuthenticationManager {
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String)async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        
        try await user.updateEmail(to: email)
    }
    
}

//MARK: Sign In SSO
extension AuthenticationManager {
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authdataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authdataResult.user)
    }
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
       return try await signIn(credential: credential)
    }

}
