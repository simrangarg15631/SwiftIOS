//
//  NetworkManager.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//

import Foundation
import SwiftUI

struct NetworkManager{
    
    //MARK: Method
    
    /// - Parameters:
    ///   - url: URL? whose value will be given from ContentViewModel
    ///   - completion: escaping closure which takes Result as an argument
    ///      if succes: ApiModel which models response from API
    ///     if failure: APIError which is a custom error model defined in the networking module

    func fetch(url: URL?, completion: @escaping(Result<ApiModel,APIError>)-> Void){
        
        //Check for url
        guard let url = url else{
            // error if url is empty
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: url , completionHandler: {(data, response , error) in
            
            //Check if url is working
            if let error = error as? URLError{
                // if server error
                completion(Result.failure(APIError.url(error)))
            }
            //Check if response is fine
            else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                // if response error
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            }
            //data from API
            else if let data = data{
                DispatchQueue.main.async {
                    do{
                        //decoding API response in our ApiModel
                        let json = try JSONDecoder().decode(ApiModel.self, from: data)
                        completion(Result.success(json))
                    }
                    
                    catch {
                        // if any decoding error
                        completion(Result.failure(APIError.parsing(error as? DecodingError)))
                    }
                }
            }
        })
        task.resume()
    }
    
}
