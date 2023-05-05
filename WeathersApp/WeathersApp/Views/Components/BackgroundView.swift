//
//  BackgroundView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 10/04/23.
//

import SwiftUI

struct BackgroundView: View {
    
    @StateObject var vm: ContentViewModel
    
    var body: some View {
        
        if vm.currWeather.weather != nil{
            if vm.currWeather.weather![0].icon.suffix(1) == "n"{
                Image(K.Images.nightBg)
                    .resizable()
                    .ignoresSafeArea()
            }
            else{
                Image(K.Images.dayBg)
                    .resizable()
                    .ignoresSafeArea()
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(vm: ContentViewModel())
    }
}
