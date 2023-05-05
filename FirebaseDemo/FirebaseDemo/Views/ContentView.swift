//
//  ContentView.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 10/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView = false
    
    var body: some View {
        
        ZStack{
            //if user already Logged In
            if !showSignInView{
                NavigationStack{
                    SettingsView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        //If user is not Logged In
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                HomeView(showSignInView: $showSignInView)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
