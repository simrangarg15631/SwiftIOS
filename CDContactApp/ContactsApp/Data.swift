//
//  Data.swift
//  ContactsApp
//
//  Created by Simran Garg on 24/02/23.
//

import Foundation

//Static Data
class Data{
    
    //MARK: Properties
    private let contactData = ContactRepository()
    
    var firstnameArr: [String] = [
        "Benjamin",
        "Melissa",
        "Carly",
        "",
        "Cameron",
        "Lucas",
        "Eric",
        "Morgan",
        "Miranda"
//        ""
    ]
    
    var lastnameArr:[String] = [
        "Lopez",
        "Blake",
        "",
        "Mercado",
        "Frazier",
        "Fowler",
        "Evans",
        "Johnston",
        "Hernandez"
//       ""
    ]
    var companyArr:[String] = [
        "",
        "Chicmic",
        "Annie",
        "",
        "",
        "Producer",
        "",
        "",
        ""
//      ""
    ]

    var phoneArr: [[String]] = [
        ["(446) 796-2839","(513) 931-0666","(770) 925-5040"],
        ["(622) 938-8377"],
        ["(369) 937-3664"],
        ["(968) 644-8567"],
        ["(439) 546-3289"],
        ["(419) 449-1498"],
        ["(408) 828-7469"],
        ["(654) 715-8280"],
        ["(678) 215-9055"]
//        ["(870) 745-2405"]
    ]
    
    //MARK: Methods
    func makeArray(){
        for i in 0..<firstnameArr.count{
            //creating contact in CDContact
            contactData.create(contact: Contact(id:UUID(), firstName: firstnameArr[i], lastName: lastnameArr[i], Company: companyArr[i], phone: phoneArr[i]))
        }
    }
}

