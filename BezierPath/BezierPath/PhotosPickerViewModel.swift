//
//  PhotosPickerViewModel.swift
//  BezierPath
//
//  Created by Saheem Hussain on 05/05/23.
//

import Foundation

import SwiftUI
import PhotosUI


class PhotosPickerViewModel: ObservableObject{
    
    //MARK: Properties
    @Published var image: Image?
    @Published var imageSelection: PhotosPickerItem?{
        didSet{
            if let imageSelection{
                Task{
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws{
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data){
                    self.image = Image(uiImage: uiImage)
                }
            }
        }catch{
            print(error.localizedDescription)
            image = nil
        }
    }
}
