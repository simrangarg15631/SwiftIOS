//
//  SelectionView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 05/04/23.
//

import SwiftUI

struct SelectionView: View {
    
    @StateObject var vm: ContentViewModel
    @Binding var rootPresenting: Bool
    @Binding var lat: String
    @Binding var lon: String
    
    var body: some View {
        
        ZStack {
            //MARK: Background Image
            BackgroundView(vm: vm)
            
            ScrollView {
                VStack(spacing: 20) {
                        //MARK: Enter New Location
                        Text(K.Strings.enterNewLocation)
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                    
                        //MARK: Latitude TextField
                        TextField(text: $lat, label: {
                            Text(K.Strings.latitude)
                                .foregroundColor(.gray)
                        })
                        .padding(12)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding(.horizontal, 5)
                            
                    
                        //MARK: Longitude TextField
                        TextField(text: $lon, label: {
                            Text(K.Strings.longitude)
                                .foregroundColor(.gray)
                        })
                        .padding(12)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding(.horizontal, 5)
                        
                       //MARK: Done Button
                        Button{
                            vm.lat = lat
                            vm.lon = lon
                            vm.fetchWeather()
                            //goes back to previous page
                            rootPresenting = false
                        }label:{
                            Text(K.Strings.done)
                                .font(.title2)
                                .foregroundColor(.gray)
                                .bold()
                                .padding(12)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding()
                       //present alert if any error
                        .alert(isPresented: $vm.showingAlert, error: vm.errorMessage){
                            Button(K.Strings.ok, action: {})
                        }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(vm: ContentViewModel(), rootPresenting: Binding.constant(true), lat: Binding.constant(""), lon: Binding.constant(""))
    }
}
