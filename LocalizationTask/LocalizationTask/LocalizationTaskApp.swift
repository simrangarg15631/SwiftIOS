//
//  LocalizationTaskApp.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 29/03/23.
//

import SwiftUI

@main
struct LocalizationTaskApp: App {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var body: some Scene {
        WindowGroup {
            if language == .arabic{
                ContentView()
                    .environment(\.layoutDirection, .rightToLeft)
            }else{
                ContentView()
            }
        }
    }
}
