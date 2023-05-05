//
//  CDContact+CoreDataProperties.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 14/03/23.
//
//

import Foundation
import CoreData


extension CDContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContact> {
        return NSFetchRequest<CDContact>(entityName: "CDContact")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var company: String?
    @NSManaged public var phone: [String]?
    
    //Created by me
    func convertToContact() -> Contact {
        return Contact(id: self.id!, firstName: self.firstName!, lastName: self.lastName!, Company: self.company!, phone: self.phone!)
    }
}

extension CDContact : Identifiable {

}
