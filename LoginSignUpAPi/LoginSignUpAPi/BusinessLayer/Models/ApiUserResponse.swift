//
//  ApiUserResponse.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 04/05/23.
//

import Foundation

struct ApiUserResponse: Codable {
    var status : Status
    var imageUrl: URL?
    
    enum CodingKeys: String, CodingKey{
        case status
        case imageUrl = "image_url"
    }
}

struct Status: Codable {
    var code : Int
    var message : String
    var data : DataDetails
}

struct DataDetails: Codable {
    var userId : Int
    var id : Int
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey{
        case userId = "user_id"
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case age
        case gender
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
