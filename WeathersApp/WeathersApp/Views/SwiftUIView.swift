//
//  SwiftUIView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 11/04/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
        ZStack{
            //MARK: Background Image
            Image(K.Images.dayBg)
                .resizable()
                .ignoresSafeArea()
            
            
            //            GeometryReader { geometry in
            //                ScrollView {
            VStack(alignment: .leading, spacing: 10){
                
                HStack{
                    Image(K.Images.location)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .colorInvert()
                    
                    Text(K.Strings.unnamed)
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    Spacer()
                    
                    Image(systemName: K.Images.plusIcon)
                        .foregroundColor(.white)
                }
                .padding()
                
                Text("32")
                    .font(.system(size: 120))
                    .foregroundStyle(.linearGradient(colors: [.white, .white.opacity(0.3)], startPoint: .top, endPoint: .bottom))
                    .padding(.horizontal)
                
                VStack(spacing:1){
                    //Icon for Clear Sky
                    Image(systemName: K.Images.sunIcon)
                        .font(.title)
                        .foregroundColor(.white)
                    
                    //MARK: Weather Description
                    Text("Clear Sky")
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
                        VStack(alignment: .leading){
                            SheetView(imageName: K.Images.celsius , title: K.Strings.feelLike, content: "16º")
                            
                            SheetView(imageName: K.Images.humidity , title: K.Strings.humidity, content: "18%")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            SheetView(imageName: K.Images.wind, title: K.Strings.windSpeed, content: "23")
                            
                            SheetView(imageName: K.Images.wind, title: K.Strings.visibility, content: "23")
                        }
                    }
                    .padding()
                }
                //                        .padding()
                .background(.white.opacity(0.98))
                
            }
            //                    .frame(minHeight: geometry.size.height + 30)
            //                }
            //            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
