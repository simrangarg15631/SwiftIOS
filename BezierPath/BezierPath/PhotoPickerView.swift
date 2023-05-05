//
//  PhotosPickerView.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    
    //MARK: Properties
    @StateObject var imagePicker = PhotosPickerViewModel()
    @Binding var profilePic: Image
    var body: some View {
        
        //MARK: Photo Picker
        PhotosPicker(
            selection: $imagePicker.imageSelection,
            matching: .images
        ){
            Image(systemName: "person.circle")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 40 , height: 40)
                .background(Color.red.opacity(0.8))
                .clipShape(Circle())
        }
        .onChange(of: imagePicker.image, perform: { _ in
            if let image = imagePicker.image{
                profilePic = image
            }
        })
    }
}


struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView(profilePic: Binding.constant(Image("Image 1")))
    }
}

