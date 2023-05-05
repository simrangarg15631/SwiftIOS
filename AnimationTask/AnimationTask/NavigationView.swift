//
//  NavigationView.swift
//  AnimationTask
//
//  Created by Saheem Hussain on 24/04/23.
//

import SwiftUI

struct NavigationView: View {
    
    @Binding var showMenu:Bool
    var body: some View {
        HStack{
            Text("Employee List")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Spacer()
            Button(action: {}, label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
            })
            Button(action: {}, label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(.white)
            })
            Button(action: {
                showMenu = false
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            })
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(showMenu: Binding.constant(true))
            .background(Color("appBlue"))
    }
}
