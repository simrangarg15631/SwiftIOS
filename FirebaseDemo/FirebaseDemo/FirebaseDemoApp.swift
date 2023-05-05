//
//  FirebaseDemoApp.swift
//  FirebaseDemo
//
//  Created by Saheem Hussain on 07/04/23.
//

import SwiftUI
import Firebase

@main
struct FirebaseDemoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
