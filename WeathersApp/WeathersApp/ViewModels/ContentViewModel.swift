//
//  ContentViewModel.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//

import Foundation
import SwiftUI

final class ContentViewModel: ObservableObject{
    
    //MARK: Properties
    @Published var showingAlert = false
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: APIError?
    @Published var currWeather: ApiModel = ApiModel.data
    
    @Published var lat: String = "30.68"
    @Published var lon: String = "76.7221"
    
    
    //MARK: Initialiser
    init(){
        fetchWeather()
    }
    
    //MARK: Method
    
    func fetchWeather(){
        
        //Used as Activity indicator- When true LoadingView is shown
        isLoading = true
        
        //Object of NetworkManager struct which handles the API
        let network = NetworkManager()
        
        //URL to call API which takes latitude and longitude entered by user and the APIKey
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=e2a0b32c90fba1d4daa3989f959767b1&units=metric")
        
        //Calling fetch function to call API
        network.fetch(url: url){ result in

            DispatchQueue.main.async {
                //tells the app loaading is finished
                self.isLoading = false
                
                switch result{
                //In case of error
                case .failure(let error):
                    //Propert to indicate when Alert will be shown to the user to inidicate error showing errorMessage
                    self.showingAlert = true
                    self.errorMessage = error as APIError
                
                //In case of success
                case .success(let currentWeather):
                    //Response from API will be stroed in the instance of APIModel
                    self.currWeather = currentWeather
                }
            }
        }
    }
}

