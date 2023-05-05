//
//  ContentView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()
    
    var body: some View {
        
        if vm.isLoading == true{
            //Activity Indicator
            LoadingView()
        }
        else{
            HomeView(vm: vm)
            //Alert is shown when there is an error
                .alert(isPresented: $vm.showingAlert, error: vm.errorMessage){
                    Button(K.Strings.ok, action: {})
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
