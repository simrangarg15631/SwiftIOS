//
//  CoreDataViewModel.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 19/04/23.
//

import Foundation
import CoreData

class CoreDataManager{
    
    //MARK: Properties
    let container: NSPersistentContainer
    
    //MARK: Initialiser
    init(){
        container = NSPersistentContainer(name: "CDContact")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print(error)
            }
        }
    }
    
    //MARK: Methods
    
    
    /// to get all contacts from Core data
    /// - Returns: Array of Contact type
    func getAll() -> [Contact]?{
        let request = NSFetchRequest<CDContact>(entityName: "CDContact")
        
        do{
            let result = try container.viewContext.fetch(request)
            var contacts: [Contact] = []
            
            result.forEach({ (cdContact) in
                contacts.append(cdContact.convertToContact())
            })
            return contacts
        }
        catch let error{
            print("Error fetching. \(error)")
        }
        
        return nil
    }
    
    
    /// to create new contact in core data
    /// - Parameter contact: Contact type
    func create(contact: Contact){
        let cdcontact = CDContact(context: container.viewContext)
        cdcontact.firstName = contact.firstName
        cdcontact.lastName = contact.lastName
        cdcontact.id = contact.id
        cdcontact.company = contact.company
        cdcontact.profilePic = contact.profilePicture
        cdcontact.phone = contact.phone
        cdcontact.url = contact.url
        cdcontact.email = contact.email
        cdcontact.notes = contact.notes
        cdcontact.address = contact.address
        cdcontact.socialProfile = contact.socialProfile
        cdcontact.instantMssg = contact.instantMssg
        
        saveData()
    }
    
    
    /// to get a particular contact identified by id
    /// - Parameter id: UUID from which contact is identified
    /// - Returns: if found returns Conatct type else nil
    func get(byIdentifier id: UUID) -> Contact? {
        //see getCDEmployee func
        let result = getCDContact(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToContact()
        
    }
    
    
    /// to update the changes made in contact oin core data
    /// - Parameter contact: takes Contact type
    func update(contact:Contact) {
        //retrieve the record which is to be updated
        let cdcontact = getCDContact(byIdentifier: contact.id)
        guard cdcontact != nil else {return}
        
        cdcontact?.firstName = contact.firstName
        cdcontact?.lastName = contact.lastName
        cdcontact?.company = contact.company
        cdcontact?.profilePic = contact.profilePicture
        cdcontact?.phone = contact.phone
        cdcontact?.url = contact.url
        cdcontact?.email = contact.email
        cdcontact?.notes = contact.notes
        cdcontact?.address = contact.address
        cdcontact?.socialProfile = contact.socialProfile
        cdcontact?.instantMssg = contact.instantMssg
        
        saveData()
        
        return
    }
    
    
    /// to delete contact from core data
    /// - Parameter id: UUID type to identify contact
    func delete(id: UUID) {
        
        let cdcontact = getCDContact(byIdentifier: id)
        guard cdcontact != nil else {return}
        container.viewContext.delete(cdcontact!)
        saveData()
    }
    
    /// created a private func to check whether the given record exists in database or not
    /// - Parameter id: UUID type to identify conatct from core data
    /// - Returns: if found returns CDConatct (Core Data Model) type else nil
    private func getCDContact(byIdentifier id: UUID) ->CDContact? {
        
        //Create a fetchRequest
        let fetchRequest = NSFetchRequest<CDContact>(entityName: "CDContact")
        //To pass the condition in fetchRequiest we need to use a predicate
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do{
            let result = try container.viewContext.fetch(fetchRequest).first
            
            guard result != nil else { return nil }
            return result
        }
        catch let error{
            debugPrint(error)
        }
        return nil
    }
    
    
    /// to save changes in coredata
    func saveData(){
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving. \(error)")
        }
    }
}
