//
//  ContactsRepository.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 14/03/23.
//

import Foundation
import CoreData

protocol ContactDataRepository{
    
    func create(contact:Contact)
    func getAll() -> [Contact]?
    func get(byIdentifier id: UUID) -> Contact?
    func update(contact:Contact)
    func delete(id: UUID)
}

struct ContactRepository: ContactDataRepository {
    
    //Create
    func create(contact:Contact) {
        let cdcontact = CDContact(context: PersistentStorage.shared.context)
        cdcontact.firstName = contact.firstName
        cdcontact.lastName = contact.lastName
        cdcontact.id = contact.id
        cdcontact.company = contact.Company
        cdcontact.phone = contact.phone
        
        PersistentStorage.shared.saveContext()
        
    }
    
    //Retrieve all
    func getAll() -> [Contact]? {
        
        do{
            guard let result = try PersistentStorage.shared.context.fetch(CDContact.fetchRequest()) as? [CDContact] else {return nil}
            
            //result is of [CDEmployee] but func returns type [Employee]
            var contacts: [Contact] = []
            
            result.forEach({ (cdContact) in
                contacts.append(cdContact.convertToContact())
            })
            
            return contacts
        }
        
        catch let error {
            debugPrint(error)
        }
        
        return nil
    }
    
    //Retrieve data of a particular employee using predicate
    func get(byIdentifier id: UUID) -> Contact? {
        //see getCDEmployee func
        let result = getCDContact(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToContact()
        
    }
    
        //Update
    func update(contact:Contact) {
            //retrieve the record which is to be updated
            let cdcontact = getCDContact(byIdentifier: contact.id)
            guard cdcontact != nil else {return}
            
            cdcontact?.firstName = contact.firstName
            cdcontact?.lastName = contact.lastName
            cdcontact?.company = contact.Company
            cdcontact?.phone = contact.phone
            PersistentStorage.shared.saveContext()
            
            return
        }
        
        //Delete
        func delete(id: UUID){
            let cdcontact = getCDContact(byIdentifier: id)
            guard cdcontact != nil else {return}
            
            PersistentStorage.shared.context.delete(cdcontact!)
            PersistentStorage.shared.saveContext()
        }
    
//    created a private func to check whether the given record exists in database or not
    private func getCDContact(byIdentifier id: UUID) ->CDContact? {
        
        //Create a fetchRequest
        let fetchRequest = NSFetchRequest<CDContact>(entityName: "CDContact")
        //To pass the condition in fetchRequiest we need to use a predicate
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do{
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else { return nil }
            return result
        }
        catch let error{
            debugPrint(error)
        }
        return nil
    }
}
