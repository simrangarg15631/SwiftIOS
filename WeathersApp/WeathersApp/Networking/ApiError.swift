//
//  ApiError.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//


import Foundation

//Custom Error Model
enum APIError: LocalizedError {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    
    var errorDescription: String?{
        switch self{
        case .badURL:
            return "Please specify URL"
        case .badResponse(_):
            return "Please enter valid coordinates"
        case .url(let error):
            return error?.localizedDescription ?? "URL session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .unknown:
            return "Sorry, something went wrong."
        }
    }
}
