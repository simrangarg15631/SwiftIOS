//
//  EditViewController.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 28/02/23.
//

import UIKit

class EditViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var firstNameTxtFld: UITextField!
    
    @IBOutlet weak var lastNamTxtFld: UITextField!
    
    @IBOutlet weak var CompTxtFld: UITextField!
    
    @IBOutlet weak var tablView: UITableView!
    
    //MARK: Properties
    var strfirstname:String!
    var strlastName:String!
    var strcompany:String!
    var strphnnumber: [String]!
    weak var deleteContactDelegate: CRUDContact?
    var editContactCell = 1
    var editContactArr:[EditPhoneTableViewCell?] = [nil]

    
    //MARK: Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTxtFld.text = strfirstname
        lastNamTxtFld.text = strlastName
        CompTxtFld.text = strcompany
        
        editContactCell = strphnnumber.count + 1
        
        tablView.isEditing = true
        tablView.allowsSelectionDuringEditing = true
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainVC = segue.destination as! ViewController
        let oldContact = Contact(firstName: strfirstname, lastName: strlastName, Company: strcompany, phone: strphnnumber)
        let updatedContact = Contact(firstName: firstNameTxtFld.text ?? strfirstname, lastName: lastNamTxtFld.text ?? strlastName, Company: CompTxtFld.text ?? strcompany, phone: strphnnumber)
        mainVC.updateContact(oldContact: oldContact, updateContact: updatedContact)
    }
    
 
    //MARK: Action
    @IBAction func DoneBtnTap(_ sender: UIBarButtonItem) {
//        let oldContact = Contact(name: strname, phone: strphn)
//        let updatedContact = Contact(name: nameField.text ?? "", phone: phoneField.text ?? "")
//        updatedelegate?.updateContact(oldContact: oldContact, updateContact: updatedContact)
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(sheet, animated: true, completion: nil)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteBtn = UIAlertAction(title: "Delete Contact", style: .destructive){ (action) in
            let deletedContact = Contact(firstName: self.strfirstname, lastName: self.strlastName, Company: self.strcompany, phone: self.strphnnumber)
            self.deleteContactDelegate?.deleteContact(contact: deletedContact)
         self.navigationController?.popToRootViewController(animated: true)
        }
        sheet.addAction(deleteBtn)
        sheet.addAction(cancelBtn)
        
//
    }
}

//MARK: TableView Extension
extension EditViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editContactCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if editContactCell == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditTableViewCell
            return cell
        }else{
            editContactCell-=1
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditPhoneTableViewCell
            cell.PhoneTXTFLd.text = strphnnumber[indexPath.row]
            editContactArr.insert(cell, at: indexPath.row)
            return cell
        }
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if editContactArr[indexPath.row] == editContactArr[editContactArr.count-1] {
    //            editContactCell+=1
    //            self.tablView.performBatchUpdates({
    //                self.tablView.insertRows(at: [IndexPath(row:indexPath.row-1, section: 0)], with: .automatic)}, completion: nil)
    //        }
    
    //    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if editContactArr[indexPath.row] == editContactArr[editContactArr.count-1]{
            return .insert
        }else {
            return .delete
        }
    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .insert{
    //            if editContactArr[indexPath.row] == editContactArr[editContactArr.count-1] {
    //                editContactCell+=1
    //                self.tablView.performBatchUpdates({
    //                    self.tablView.insertRows(at: [IndexPath(row:0, section: 0)], with: .automatic)}, completion: nil)
    //            }
    //        }
    //        else if editingStyle == .delete{
    //            editContactArr.remove(at: indexPath.row)
    //            editContactCell-=1
    //            self.tablView.performBatchUpdates({
    //                self.tablView.deleteRows(at: [IndexPath(row:indexPath.row, section:0)], with: .automatic)
    //         })
    //        }
    //    }
    
}
