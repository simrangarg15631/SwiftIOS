//
//  Data.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 24/02/23.
//

import Foundation

//Static Data
class Data{
    
    //MARK: Properties
    
    var firstnameArr: [String] = [
        "Benjamin",
        "Melissa",
        "Carly",
        "",
        "Cameron",
        "Lucas",
        "Eric",
        "Morgan",
        "Miranda",
        ""
//        "Jay Donaldson",
//        "Raymond Fowler",
//        "Brandi Harrison",
//        "Susan Stokes",
//        "Emily Bennett",
//        "Joshua Hansen",
//        "Lisa Rodriguez",
//        "Michael Jackson",
//        "Cameron Richards",
//        "Christopher Dunn",
//        "Daniel Chung",
//        "Morgan Newman",
//        "Clinton Castaneda",
//        "Lee Jones",
//        "Michael Andrews",
//        "Carol Horne",
//        "David Jackson",
//        "Jennifer Myers",
//        "Dr. Whitney Jones",
//        "Nicholas Roth",
//        "Catherine Wilson",
//        "Paul Mooney",
//        "John Lutz",
//        "Jordan Neal",
//        "Joshua Torres",
//        "Brittany Jensen",
//        "John Schultz",
//        "Virginia Banks",
//        "Robert Rodriguez",
//        "Thomas Rodriguez II",
//        "Erin Jones",
//        "Kevin Mitchell",
//        "Chelsea Hanson",
//        "Isaac Rowe",
//        "Ronald Young",
//        "Stephanie West",
//        "Jennifer Haley",
//        "Rachel Wilson",
//        "Robert Wright",
//        "Brittany Casey",
//        "Cassandra Mcguire",
//        "Jason Walker",
//        "Jeffery Vang",
//        "Heather Brown",
//        "Barbara Davis",
//        "Kimberly Monroe",
//        "Erica Klein",
//        "Kara Bennett",
//        "Stacey Green",
//        "Amber Middleton",
//        "Taylor Davis",
//        "Nathaniel Kennedy",
//        "Sean Clark",
//        "Kayla Reeves",
//        "Aaron Mckenzie"
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
        "Hernandez",
        ""]
    
    var companyArr:[String] = [
        "",
        "Chicmic",
        "Annie",
        "",
        "",
        "Producer",
        "",
        "",
        "",
        ""
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
        ["(678) 215-9055"],
        ["(870) 745-2405"]
//        "(513) 931-0666",
//        "(770) 925-5040",
//        "(915) 648-0171",
//        "(283) 630-5775",
//        "(680) 530-5673",
//        "(847) 508-7676",
//        "(263) 484-8241",
//        "(347) 293-7201",
//        "(733) 271-4786",
//        "(914) 806-6179",
//        "(852) 900-5708",
//        "(626) 813-3518",
//        "(502) 782-8292",
//        "(874) 516-5800",
//        "(229) 672-3797",
//        "(848) 504-4389",
//        "(470) 521-6896",
//        "(513) 264-1828",
//        "(625) 480-4685",
//        "(486) 408-6932",
//        "(830) 454-0112",
//        "(608) 839-3304",
//        "(905) 412-7806",
//        "(633) 323-9469",
//        "(206) 832-4573",
//        "(450) 763-7614",
//        "(812) 601-2707",
//        "(481) 597-3639",
//        "(994) 706-0745",
//        "(812) 930-7249",
//        "(395) 726-5530",
//        "(337) 547-1936",
//        "(972) 577-4193",
//        "(886) 763-2255",
//        "(909) 327-7048",
//        "(612) 594-8243",
//        "(813) 963-4814",
//        "(752) 753-6872",
//        "(535) 731-0110",
//        "(933) 412-8230",
//        "(655) 363-7026",
//        "(509) 781-6257",
//        "(786) 206-7747",
//        "(956) 589-9547",
//        "(613) 864-8350",
//        "(213) 566-5901",
//        "(667) 999-1961",
//        "(509) 632-8558",
//        "(722) 632-1094",
//        "(297) 246-9770",
//        "(302) 985-3379",
//        "(570) 904-7878",
//        "(892) 620-5405",
//        "(242) 603-4631",
//        "(887) 476-1035"
    ]
    
    var contactArray=[Contact]() //Array of Contact objects
    
    //MARK: Methods
    
    func makeArray(){
        for i in 0..<firstnameArr.count{
            //object of Contact
            let contact = Contact(firstName: firstnameArr[i], lastName: lastnameArr[i], Company: companyArr[i], phone: phoneArr[i])
            contactArray.append(contact)
        }
        //print("contactArray: \(contactArray)")
    }
}

