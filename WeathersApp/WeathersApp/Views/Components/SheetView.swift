//
//  SheetView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//

import SwiftUI

struct SheetView: View {
    
    var imageName = K.Images.celsius
    var title = K.Strings.feelLike
    var content = "16º"
    
    var body: some View {
        
        HStack(spacing: 20){
            
            Image(imageName)
                .resizable()
                .frame(width:20, height: 20)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
                
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(Color.gray)
                Text(content)
                    .foregroundColor(.black)
                    .font(.headline)
            }
        }
        .background(Color.white)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
