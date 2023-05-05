//
//  ViewModel.swift
//  ContactsAppSwiftUI
//
//  Created by Saheem Hussain on 17/04/23.
//

import Foundation

class ContentViewModel: ObservableObject{
    
    //MARK: Properties
    let core = CoreDataManager()
    //to store section Titles
    @Published var sectionTitleArray = [String]()
    @Published var contactDict = [String: [Contact]]()
    @Published var searchResults: [Contact]?
    
    var phoneType = [Key.Strings.mobile, Key.Strings.home, Key.Strings.work, Key.Strings.school,Key.Strings.iPhone, Key.Strings.appleWatch, Key.Strings.main, Key.Strings.homeFax, Key.Strings.workFax, Key.Strings.pager, Key.Strings.other]
    
    var sideIndex = Array(Key.Strings.alphabelts.uppercased()).compactMap({"\($0)"})
    
    //MARK: Initialiser
    init(){
        getContacts()
    }
    
    //MARK: Methods
    
    
    /// to get contacts from coredata and sort them
    func getContacts(){
        searchResults = core.getAll()
        sortContacts(in: searchResults)
    }
     
    
    /// to sort the contacts
    /// - Parameter contact: Array of type Contact
    func sortContacts(in contact: [Contact]?){
        
        guard let contact = contact else{
            return
        }
        var sections = [String]()
        
        //Retrieving and sorting SectionTitles
        for cont in contact{
            if cont.getfullname() != "" {
                let prfx = String(cont.getfullname().prefix(1))
                if (prfx >= "a" && prfx <= "z") || (prfx >= "A" && prfx <= "Z") {
                    sections.append(prfx)
                }
            }
        }
        
        sectionTitleArray = Array(Set(sections))
        sectionTitleArray.sort()
        sectionTitleArray.append("#")
        
        contactDict = [String: [Contact]]()
        //creating empty array of type Contact for each sectiontitle in contactDict
        for stitle in sectionTitleArray {
            contactDict[stitle] = [Contact]()
        }
        
        //Appending contact in contactDict acc to their name prefixes
        for cont in contact{
            
            // if full name present
            if cont.getfullname() != ""{
                let prfx = String(cont.getfullname().prefix(1))
                //if name starting with letters
                if  ((prfx >= "a" && prfx <= "z") || (prfx >= "A" && prfx <= "Z") ){
                    contactDict[prfx]?.append(cont)
                }
                //if name starting with numbers
                else{
                    contactDict["#"]?.append(cont)
                }
            }
            // if phone numbers are given
            else if !cont.phone.isEmpty{
                contactDict["#"]?.append(cont)
            }
            // if url or address or notes are given
            else if !cont.url.isEmpty || !cont.address.isEmpty || !cont.notes.isEmpty || cont.profilePicture.count != 0 || !cont.socialProfile.isEmpty || !cont.instantMssg.isEmpty{
                contactDict["#"]?.append(cont)
            }
        }
        
        let ind = sectionTitleArray.count-1 //index of #
        //if no contact at key # remove that section
        if contactDict[sectionTitleArray[ind]]?.count == 0 {
                contactDict.removeValue(forKey: sectionTitleArray[ind]) //deletes the key value pair for that index
                sectionTitleArray.remove(at: ind)
        }
        
        //Sorting rows in each section acc to their names
        for (key, _) in contactDict {
            contactDict[key] = contactDict[key]?.sorted(by: {
                if key != "#"{
                        return $0.getfullname().uppercased() < $1.getfullname().uppercased()
                }
                else{
                    if $0.getfullname() != "" && $1.getfullname() != "" {
                        return $0.phone[0] < $1.phone[0]
                    }
                    else{
                        return $0.getfullname().uppercased() < $1.getfullname().uppercased()
                    }
                }
            })
        }
    }
}
