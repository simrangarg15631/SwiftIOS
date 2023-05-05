//
//  RowView.swift
//  AnimationTask
//
//  Created by Saheem Hussain on 24/04/23.
//

import SwiftUI

struct RowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 15){
            Circle()
                .frame(width:36)
                
            VStack(alignment: .leading){
                Text("Name")
                Text("Designation")
                
                HStack{
                    Text("IN: -- --")
                    Spacer()
                    Text("OUT: -- --")
                }
                .padding(.top, 12)
            }
        }
        .foregroundColor(.white)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
            .background(Color("appBlue"))
    }
}
