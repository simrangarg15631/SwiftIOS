//
//  PersistentStorage.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 14/03/23.
//

import Foundation
import CoreData

class PersistentStorage {
    private init(){}
    static let shared = PersistentStorage()
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CDContact")
        //Load any persistent stores. This call creates a store, if none exists
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
//        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
