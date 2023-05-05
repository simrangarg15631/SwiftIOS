//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Simran Garg on 22/02/23.
//

import UIKit

class DetailViewController: UIViewController{
    
    
    
    //MARK: Outlets
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet weak var companyLbl: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: Properties
    var strFirstName:String!
    var strLastName:String!
    var strCompany:String!
    var strPhn:[String]!
    weak var mainVCdelegate: CRUDContact?
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = strFirstName + " " + strLastName
        companyLbl.text = strCompany
    }
    
    //MARK: Actions
    @IBAction func editBtn(_ sender: UIBarButtonItem) {
        let edit = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        edit.strfirstname = strFirstName
        edit.strlastName = strLastName
        edit.strcompany = strCompany
        edit.strphnnumber = strPhn
        edit.deleteContactDelegate = mainVCdelegate
        self.navigationController?.pushViewController(edit, animated: true)
    }
}

//MARK: TableView Extension
extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strPhn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        cell.phnLabel.text = strPhn[indexPath.row]
        return cell
    }
}
