//
//  ContentView.swift
//  BezierPath
//
//  Created by Saheem Hussain on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    @State private var profilePic: Image = Image("Image 1")
    var body: some View {
        ZStack{
            
            CustomShape()
                .fill(Color.blue.opacity(0.6))
                .frame(width:200, height: 200)
            
            profilePic
                .resizable()
                .frame(width:170, height: 170)
                .clipShape(CustomShape())
            
            PhotoPickerView(profilePic: $profilePic)
                .offset(CGSize(width: 75, height: 78))
        }
    }
}

struct CustomShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        
        Path{ path in
            
            let width: CGFloat = rect.width/2
            let height: CGFloat = rect.height/2
            
            path.addArc(center: CGPoint(x: width, y: height), radius: width, startAngle: Angle(degrees: 390), endAngle: Angle(degrees: 60), clockwise: true)
            
            path.addQuadCurve(to: CGPoint(x: (width/2) * (2 + sqrt(3)), y: height * (3/2)), control: CGPoint(x: width+40, y: height * (3/2)))
            
            path.closeSubpath()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
