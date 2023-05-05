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
    private let contactsData = ContactRepository()
    var contact:Contact? = nil
    var strid: UUID!
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editBtnAction))
    }
    override func viewWillAppear(_ animated: Bool) {
        contact = contactsData.get(byIdentifier: strid)
        nameLbl.text = "\(contact?.firstName ?? "") \(contact?.lastName ?? "")"
        companyLbl.text = contact?.Company ?? ""
        tblView.reloadData()
    }
    
    @objc func editBtnAction(){
        let edit = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        edit.strid = strid
        self.navigationController?.pushViewController(edit, animated: true)
    }
    
}
    
//MARK: TableView Extension
extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact?.phone.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        cell.phnLabel.text = contact?.phone[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
