//
//  Segmented Picker.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 30/03/23.
//

import SwiftUI

struct Segmented_Picker: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @State private var pickerSelection = 1
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        Picker("", selection: $pickerSelection)
        {
            Text("kg/cm".localized(language)).tag(0)
            Text("lbs/inch".localized(language)).tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.white)
        .frame(width:180)
        .cornerRadius(10)
        .shadow(color: Color.orange, radius: 1)
        .padding(.horizontal, 5)
    }
}

struct Segmented_Picker_Previews: PreviewProvider {
    static var previews: some View {
        Segmented_Picker()
    }
}
