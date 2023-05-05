//
//  ContentView.swift
//  AnimationTask
//
//  Created by Saheem Hussain on 24/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showMenu = false
    var body: some View {
        ZStack{
            
            HStack{
                
                VStack {
                    ForEach(0..<10){ _ in
                        Circle()
                            .frame(width:36)
                            .foregroundColor(.white)
                    }
                    .padding(10)
                }
                .background(Color("appBlue"))
                .cornerRadius(10)
                .gesture(DragGesture()
                    .onChanged{ _ in
                        self.showMenu = true
                    }
                )
                
                Spacer()
            }
            
            if showMenu{
                SideMenuView(showMenu: $showMenu)
                    .frame(maxWidth: 360)
                    .offset(x: -18)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                    .animation(.easeInOut)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
