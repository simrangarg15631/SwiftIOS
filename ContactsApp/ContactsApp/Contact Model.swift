//
//  Data.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 24/02/23.
//

import Foundation

//Data Model
class Contact{
    
    //MARK: Properties
    var firstName:String
    var lastName:String
    var Company:String
    var phone:[String]
    
    
    //MARK: Initializer
    init(firstName: String, lastName: String, Company: String, phone: [String]) {
        self.firstName = firstName
        self.lastName = lastName
        self.Company = Company
        self.phone = phone
    }
    
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
        return ""
    }
}

