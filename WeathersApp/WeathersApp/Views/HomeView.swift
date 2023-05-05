//
//  HomeView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: ContentViewModel
    @State private var rootPresenting: Bool = false
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                //MARK: Background Image
                BackgroundView(vm: vm)
                
                //                GeometryReader { geometry in
                //                    ScrollView {
                VStack(alignment: .leading, spacing: 10){
                    
                    HStack{
                        Image(K.Images.location)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .colorInvert()
                        
                        //MARK: Location Name
                        if vm.currWeather.name != ""{
                            Text(vm.currWeather.name ?? "")
                                .foregroundColor(.white)
                                .font(.title2)
                        }else{
                            Text(K.Strings.unnamed)
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        //MARK: Plus Button
                        //Navigates to Selection View to enter new coordinates
                        NavigationLink(destination: SelectionView( vm: vm, rootPresenting: $rootPresenting, lat: $vm.lat, lon: $vm.lon), isActive: $rootPresenting){
                            Image(systemName: K.Images.plusIcon)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    //MARK: Temperature
                    if vm.currWeather.main != nil{
                        Text("\(Int(vm.currWeather.main!.temp))º")
                            .font(.system(size: 120))
                            .foregroundStyle(.linearGradient(colors: [.white, .white.opacity(0.3)], startPoint: .top, endPoint: .bottom))
                            .padding(.horizontal)
                    }
                    
                    if vm.currWeather.weather != nil{
                        
                        VStack(spacing:1){
                            //MARK: Weather Condition Icon
                            if vm.currWeather.weather![0].icon != "01d"{
                                AsyncImage(url: URL(string:"https://openweathermap.org/img/wn/\(String(describing: vm.currWeather.weather![0].icon))@2x.png")){ phase in
                                    if let image = phase.image{
                                        // Icon from API
                                        image
                                            .resizable()
                                            .frame(width:60, height: 60)
                                        
                                    }else{
                                        //Activity Indicator Till the icon is loading show
                                        ProgressView()
                                            .tint(.white)
                                            .frame(width:60, height: 60)
                                    }
                                }
                            }
                            else{
                                //Icon for Clear Sky
                                Image(systemName: K.Images.sunIcon)
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            
                            //MARK: Weather Description
                            Text(vm.currWeather.weather![0].description.capitalized)
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 20){
                            Text(K.Strings.weatherNow)
                                .padding()
                                .foregroundColor(.black)
                                .font(.title2)
                                .bold()
                            
                            HStack{
                                if vm.currWeather.main != nil{
                                    VStack(alignment: .leading){
                                        
                                        //MARK: Feel Like
                                        SheetView(imageName: K.Images.celsius , title: K.Strings.feelLike, content: "\(Int(vm.currWeather.main!.feelsLike))º")
                                        
                                        //MARK: Humidity
                                        SheetView(imageName: K.Images.humidity , title: K.Strings.humidity, content: "\(Int(vm.currWeather.main!.humidity))%")
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading){
                                        if vm.currWeather.wind != nil{
                                            //MARK: Wind Speed
                                            SheetView(imageName: K.Images.wind, title: K.Strings.windSpeed, content: "\(Int(vm.currWeather.wind!.speed * (18/5))) \(K.Strings.km)/\(K.Strings.h)")
                                        }
                                        
                                        if vm.currWeather.visibility != nil{
                                            //MARK: Visibility
                                            SheetView(imageName: K.Images.visibility, title: K.Strings.visibility, content: "\(Int(vm.currWeather.visibility!/1000)) \(K.Strings.km)")
                                            
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                        .background(.white.opacity(0.98))
                    }
                }
                //                        .frame(minHeight: geometry.size.height + 30)
                //                    }
                //                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: ContentViewModel())
    }
}
