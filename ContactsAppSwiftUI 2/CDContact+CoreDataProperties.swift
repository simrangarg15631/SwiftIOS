//
//  CDContact+CoreDataProperties.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 26/04/23.
//
//

import Foundation
import CoreData


extension CDContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContact> {
        return NSFetchRequest<CDContact>(entityName: "CDContact")
    }

    @NSManaged public var address: [String]?
    @NSManaged public var company: String?
    @NSManaged public var email: [String]?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var notes: String?
    @NSManaged public var phone: [String]?
    @NSManaged public var profilePic: Data?
    @NSManaged public var url: [String]?
    @NSManaged public var socialProfile: [String]?
    @NSManaged public var instantMssg: [String]?

    
    /// to convert CDContact (Core Data Model) into Contact type
    /// - Returns: Contact type
    func convertToContact() -> Contact{
        return Contact(id: self.id!,firstName: self.firstName!, lastName: self.lastName!, company: self.company!, profilePicture: self.profilePic ?? Data(), phone: self.phone!, url: self.url!, email: self.email!, address: self.address!, notes: self.notes!, socialProfile: self.socialProfile ?? [], instantMssg: self.instantMssg ?? [])
    }
}

extension CDContact : Identifiable {

}
