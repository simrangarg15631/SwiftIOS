//
//  SideMenuView.swift
//  AnimationTask
//
//  Created by Saheem Hussain on 24/04/23.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    var body: some View {
        ScrollView{
           VStack{
               NavigationView(showMenu: $showMenu)
                    .padding()
                
                ForEach(0..<20){_ in
                    RowView()
                        .padding(.horizontal)
                    Divider()
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                        
                }
            }
        }
        .background(Color("appBlue"))
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(showMenu: Binding.constant(true))
    }
}
