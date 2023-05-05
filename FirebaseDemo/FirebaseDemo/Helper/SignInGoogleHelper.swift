//
//  SignInGoogleHelper.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 11/04/23.
//

import Foundation
import GoogleSignIn

final class SignInGoogleHelper {
    
    @MainActor
    func signIn(viewController: UIViewController? = nil) async throws -> GoogleSignInResultModel {
        guard let topVC = viewController ?? topViewController() else{
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        return GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
    }
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
