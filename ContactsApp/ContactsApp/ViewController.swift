//
//  ViewController.swift
//  ContactsApp
//
//  Created by Simran Garg on 21/02/23.
//

import UIKit

//MARK: Protocol
protocol CRUDContact: AnyObject {
    func addContact(contact:Contact)
    func deleteContact(contact:Contact)
    func updateContact(oldContact: Contact, updateContact: Contact)
}

//MARK: ViewController Class
class ViewController: UIViewController,UISearchBarDelegate, UISearchControllerDelegate, CRUDContact {
    
    
    //MARK: Outlets
    @IBOutlet var tblView: UITableView!
    
    //MARK: Properties
    var contact = [Contact]() //Array of Contact Objects
    var data = Data() //can delete it when we no longer need static data
    var searchData = [Contact]()
    
    //to store sectionTitles such as A,B
    var sectionTitle = [String]()
    
    //Dictionary to store contacts acc to their name's first letter
    var contactDict = [String: [Contact]]()
    var alphabet = "abcdefghijklmnopqrstuvwxyz#"
    let searchController = UISearchController(searchResultsController: nil)
    var index=IndexPath()
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //Can remove these two lines when we don't want static data
        data.makeArray()
        contact = data.contactArray //Storing all static data in contact
        
        sortContacts(in: contact)
        searchBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblView.reloadData()
    }
    //MARK: Methods
    func sortContacts(in contact: [Contact]){
        
        var sections=[String]()
        for cont in contact{
            if cont.getfullname() != ""{
                sections.append(String(cont.getfullname().prefix(1)))
            }
        }
        //print(sections)
        
        //Retrieving and sorting SectionTitles
//        sectionTitle = Array(Set(contact.compactMap({String($0.firstName().prefix(1))})))//Here $0 is whole Contact object from contact array.
        sectionTitle = Array(Set(sections))
        sectionTitle.sort()
        //TODO: Handle #
        sectionTitle.append("#")
        //print(sectionTitle)
        
        //creating empty array of type Contact for each sectiontitle in contactDict
        for stitle in sectionTitle {
            contactDict[stitle] = [Contact]()
        }
        //Appending contact in contactDict acc to their name prefixes
        for cont in contact {
            if cont.getfullname() != ""{
                contactDict[String(cont.getfullname().prefix(1))]?.append(cont)
            }
            else{
//                if contactDict.keys.contains("#") {
                    contactDict["#"]?.append(cont)
//                }else{
//                    contactDict["#"] = [cont]
                }
                
            }
        
//        print(contactDict["#"]?[0].firstName)
        //Sorting rows in each section acc to their names
        for (key, _) in contactDict {
            contactDict[key] = contactDict[key]?.sorted(by: {
                //TODO: Sort phone numbers in sections
                $0.getfullname().uppercased() < $1.getfullname().uppercased()
            })
        }
    }
    
    func addContact(contact: Contact) {
        self.contact.append(contact)
        sortContacts(in: self.contact)
        tblView.reloadData()
    }
    
    func deleteContact(contact:Contact) {
        
//        for i in 0..<self.contact.count {
//            if (contact.phone == self.contact[i].phone) {
//                self.contact.remove(at: i)
//                break
//            }
//        }
        
        //if we remove directly from contactDict, we have to separately handle deletion of sectionTitles and also when we add a new contact it will regenerate the deleted contacts as it is already stored as static data in contact array. So it is more beneficial to remove contact from contact array directly. Like this.
        
        //remove directly from contactDict
        let deletedcontact = contactDict[sectionTitle[index.section]]?.remove(at: index.row)

        //if no contact in current section remove that section
        if contactDict[sectionTitle[index.section]]?.count == 0 {
            contactDict.removeValue(forKey: sectionTitle[index.section]) //deletes the key value pair for that index
            sectionTitle.remove(at: index.section)
        }
        
        //removing elements from the static data so no element is regenerated when a new value is added
        for i in 0..<self.contact.count {
            if (deletedcontact?.phone == self.contact[i].phone) {
                self.contact.remove(at: i)
                break
            }
        }
        tblView.reloadData()
    }
    
    func updateContact(oldContact: Contact, updateContact: Contact) {
        //delete oldContact
        for i in 0..<self.contact.count {
            if (oldContact.phone == self.contact[i].phone) {
                self.contact.remove(at: i)
                break
            }
        }
        //add updateContact
        self.contact.append(updateContact)
        sortContacts(in :contact)
        tblView.reloadData()
        
    }
    
    func searchBarSetup(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    //MARK: Action
    @IBAction func addContact(_ sender: UIBarButtonItem) {
        if let add:AddViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController {
            
            //Sheet Presentation Controller to make addVC present from bottom of screen
            if let sheet = add.sheetPresentationController {
                sheet.detents = [.large()]
            }
            add.addContactDelegate = self
            self.navigationController?.present(add, animated: true)
        }
    }
    
    @IBAction func unwindtoMain(_ sender: UIStoryboardSegue) {}
    
    
    
}

//MARK: SearchController Extension
extension ViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText != ""{
            searchData = data.contactArray.filter{$0.getfullname().contains(searchText)}
            sortContacts(in: searchData)
        }else{
            searchData = data.contactArray
            sortContacts(in: searchData)
        }
        tblView.reloadData()
    }
}




//MARK: TableView Extension
extension ViewController: UITableViewDataSource, UITableViewDelegate{

    //return number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    //return no of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDict[sectionTitle[section]]?.count ?? 0
    }
    
    //return values in a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let fullName = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].getfullname()

        let phone = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].phone[0]
        
        if fullName != ""{
            cell.textLabel?.text = fullName
        }
        else{
            cell.textLabel?.text = phone
        }
        return cell
    }

    // to display sectionTitles in Header of sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    //to display index at side
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Array(alphabet.uppercased()).compactMap({"\($0)"})
    }
    
    //To display the section when clicked at indexTitles
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let targetIndex = sectionTitle.firstIndex(where: {$0 == title}) else{
            //TODO: Check what to return when there is no sectionTitle
            return 0
        }
        return targetIndex
    }
    
    //to display details of each contact when we select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index=indexPath
        let detail:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detail.strFirstName = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].firstName
        detail.strLastName = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].lastName
        detail.strCompany = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].Company
        detail.strPhn = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].phone
        detail.mainVCdelegate = self
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
