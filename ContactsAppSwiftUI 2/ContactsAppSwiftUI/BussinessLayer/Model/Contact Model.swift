//
//  Contact Model.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 17/04/23.
//

import Foundation

//Data Model
class Contact: Identifiable{
    
    //MARK: Properties
    let id:UUID
    var firstName:String
    var lastName:String
    var company:String
    var profilePicture: Data
    var phone:[String]
    var url:[String]
    var email: [String]
    var address: [String]
    var notes: String
    var socialProfile: [String]
    var instantMssg: [String]
    
    //MARK: Initializer
    
    init(id:UUID = UUID() , firstName: String, lastName: String, company: String, profilePicture: Data, phone: [String], url: [String], email: [String], address: [String], notes: String, socialProfile: [String], instantMssg: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.profilePicture = profilePicture
        self.phone = phone
        self.url = url
        self.email = email
        self.address = address
        self.notes = notes
        self.socialProfile = socialProfile
        self.instantMssg = instantMssg
    }
    
    //MARK: Method
    func getfullname() -> String {
        
        if self.firstName != "" && self.lastName != ""{
            return self.firstName.capitalized + " " + self.lastName.capitalized
        }
        else if self.firstName != "" {
            return firstName.capitalized
        }
        else if lastName != "" {
            return lastName.capitalized
        }
        else if company != ""{
            return company.capitalized
        }
        else if email != []{
            return email[0].capitalized
        }
        return ""
    }
}
