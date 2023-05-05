//
//  CheckBox.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 29/03/23.
//

import Foundation
import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(Color.orange)
                configuration.label
            }
        })
    }
}
