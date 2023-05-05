//
//  AddViewController.swift
//  ContactsApp
//
//  Created by Simran Garg on 21/02/23.
//

import UIKit

struct TextFieldModel {
    var textFldData:String?
    init(textData: String){
        textFldData = textData
    }
}
class AddViewController: UIViewController, UITextFieldDelegate {

    //MARK: Outlets
    @IBOutlet weak var firstTxtFld: UITextField!
    
    @IBOutlet weak var lastTxtFld: UITextField!
    
    @IBOutlet weak var compTxtFld: UITextField!
    
    @IBOutlet weak var myTblView: UITableView!
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    
    //MARK: Properties
    weak var addContactDelegate: CRUDContact?
    var addContactCell = 1
    var addContactArr:[InsertPhoneTableViewCell?] = [nil]
//    var phone:[String?]
    var dataModel = [TextFieldModel]()
    var index = IndexPath()
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        saveBtn.isEnabled = false
        myTblView.isEditing = true
        
        myTblView.allowsSelectionDuringEditing = true
        
        for _ in 0..<10 {
            dataModel.append(TextFieldModel(textData: ""))
        }
        myTblView.reloadData()
    }
    
    
    //MARK: Actions
    @IBAction func doneBtnTap(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        guard let firstname = firstTxtFld.text, let lastname = lastTxtFld.text, let company = compTxtFld.text, let phn = dataModel[index.row].textFldData else{
            return
        }
        
        let newcontact = Contact(firstName: firstname, lastName: lastname, Company: company, phone: [phn])
        
        addContactDelegate?.addContact(contact: newcontact)
        self.dismiss(animated: true)
//        let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        
//        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    @IBAction func cancelBtnTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}

//MARK: TableView Extension
extension AddViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addContactCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if addContactCell - 1 == indexPath.row{
            let cell = myTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddTableViewCell
            
            return cell
            
        }else {
            let cell = myTblView.dequeueReusableCell(withIdentifier: "insertPhone", for: indexPath) as! InsertPhoneTableViewCell
//            phone.append(cell.inserPhnTxtFld.text)
            index = indexPath
            cell.inserPhnTxtFld.tag = indexPath.row
            cell.inserPhnTxtFld.delegate = self
            cell.inserPhnTxtFld.text = dataModel[indexPath.row].textFldData
            
            addContactArr.insert(cell, at: 0)
            return cell
        }
    }
            
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = NSIndexPath(row: textField.tag, section: 0)
        if let cell = myTblView.cellForRow(at: index as IndexPath) as? InsertPhoneTableViewCell {
            if index.row == textField.tag{
                dataModel[textField.tag].textFldData = textField.text
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if addContactArr[indexPath.row] == addContactArr[addContactArr.count-1] {
            addContactCell+=1
            myTblView.reloadData()
//            self.myTblView.performBatchUpdates({
//            self.myTblView.insertRows(at: [IndexPath(row:0, section: 0)], with: .automatic)}, completion: nil)
      }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if addContactArr[indexPath.row] == addContactArr[addContactArr.count-1]{
            return .insert
        }else {
            return .delete
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert{
            if addContactArr[indexPath.row] == addContactArr[addContactArr.count-1] {
                addContactCell+=1
                self.myTblView.performBatchUpdates({
                self.myTblView.insertRows(at: [IndexPath(row:0, section: 0)], with: .automatic)}, completion: nil)
            }
        }
        else if editingStyle == .delete{
            addContactArr.remove(at: indexPath.row)
            addContactCell-=1
            self.myTblView.performBatchUpdates({
                self.myTblView.deleteRows(at: [IndexPath(row:indexPath.row, section:0)], with: .automatic)
         })
        }
    }
    
    
    
    
}
