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
}

//MARK: ViewController Class
class ViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, CRUDContact {
    
    
    //MARK: Outlets
    @IBOutlet var tblView: UITableView!
    
    //MARK: Properties
    private let contactData = ContactRepository()
    var contact:[Contact]? = nil //Array of Contact Objects
//    var data = Data() //can delete it when we no longer need static data
    var searchData:[Contact]? = nil
    
    //to store sectionTitles such as A,B
    var sectionTitle = [String]()
    
    //Dictionary to store contacts acc to their name's first letter
    var contactDict = [String: [Contact]]()
    var alphabet = "abcdefghijklmnopqrstuvwxyz#"
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        let path = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)
//        debugPrint(path[0])
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        data.makeArray() //Storing all static data in CDContact
        
        searchBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        contact = contactData.getAll()
//        for cont in contact!{
//            if cont.firstName == "" && cont.lastName == "" && cont.Company == "" && cont.phone.isEmpty{
//                contactData.delete(id: cont.id)
//            }
//        }
//        contact = contactData.getAll()
        sortContacts(in: contact)
        tblView.reloadData()
    }
    
    //MARK: Methods
    func sortContacts(in contact: [Contact]?){
        
        var sections=[String]()
        for cont in contact!{
            if cont.getfullname() != ""{
                let prfx = String(cont.getfullname().prefix(1))
                if  ((prfx >= "a" && prfx <= "z") || (prfx >= "A" && prfx <= "Z") ){
                    sections.append(prfx)
                }
            }
        }
        
        //Retrieving and sorting SectionTitles
        sectionTitle = Array(Set(sections))
        sectionTitle.sort()
        sectionTitle.append("#")

        //creating empty array of type Contact for each sectiontitle in contactDict
        for stitle in sectionTitle {
            contactDict[stitle] = [Contact]()
        }
        
        //Appending contact in contactDict acc to their name prefixes
        for cont in contact! {
            
            if cont.getfullname() != ""{
                let prfx = String(cont.getfullname().prefix(1))
                if  ((prfx >= "a" && prfx <= "z") || (prfx >= "A" && prfx <= "Z") ){
                    contactDict[prfx]?.append(cont)
                }else{
                    contactDict["#"]?.append(cont)
                }
            }
            else if !cont.phone.isEmpty{
                contactDict["#"]?.append(cont)
            }
                
        }
        
        let ind = sectionTitle.count-1 //index of #
        //if no contact at key # remove that section
        if contactDict[sectionTitle[ind]]?.count == 0 {
                contactDict.removeValue(forKey: sectionTitle[ind]) //deletes the key value pair for that index
                sectionTitle.remove(at: ind)
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
    
    func addContact(contact: Contact) {
        self.contact!.append(contact)
        sortContacts(in: self.contact)
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
    
}

//MARK: SearchController Extension
extension ViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText != ""{
            searchData = contactData.getAll()?.filter{
                if $0.getfullname() != ""{
                    return $0.getfullname().uppercased().contains(searchText.uppercased())
                }else{
                    return $0.phone[0].contains(searchText)
                }
            }
            sortContacts(in: searchData)
            
        }else{
            searchData = contactData.getAll()
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
 
        if fullName != ""{
            cell.textLabel?.text = fullName
        }
        else{
            cell.textLabel?.text = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].phone[0]
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
            //return at one section before
            if title != "#"{
                guard let idx = sectionTitle.firstIndex(where: {$0 > title})  else{
                    return sectionTitle.count - 1
                }
                return idx-1
            }else{
                return sectionTitle.count - 1
            }
        }
        return targetIndex
    }
    
    //to display details of each contact when we select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.strid = contactDict[sectionTitle[indexPath.section]]?[indexPath.row].id
        self.navigationController?.pushViewController(detail, animated: true)
    }
}


