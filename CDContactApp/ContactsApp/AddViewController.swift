//
//  AddViewController.swift
//  ContactsApp
//
//  Created by Simran Garg on 21/02/23.
//

import UIKit


class AddViewController: UIViewController{

    //MARK: Outlets
    @IBOutlet weak var firstTxtFld: UITextField!
    
    @IBOutlet weak var lastTxtFld: UITextField!
    
    @IBOutlet weak var imgVIew: UIImageView!
    
    @IBOutlet weak var compTxtFld: UITextField!
    
    @IBOutlet weak var myTblView: UITableView!
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    
    //MARK: Properties
    private let contactsData = ContactRepository()
    weak var addContactDelegate: CRUDContact?
    
    var dataModel = [TextFieldModel]()
    var activeTextField:UITextField!
    var phnTextField: UITextField?
    var addContactCell = 1
    
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTblView.isEditing = true
        myTblView.allowsSelectionDuringEditing = true
        
 
        dataModel.append(TextFieldModel(textData: [""]))

        
        doneBtn.isEnabled = false
        
        //Keyboard Handling
        //Must be set for textFieldShouldReturn func to work
        firstTxtFld.delegate = self
        lastTxtFld.delegate = self
        compTxtFld.delegate = self
        
        self.hideKeyBoardTappedAround()
        
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShown(notification: Notification){
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardsize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardsize.height
        let editingTextFieldY = activeTextField.convert(activeTextField.bounds, to: self.view).minY
        
        if self.view.frame.minY>=0
        {
            if editingTextFieldY>keyboardY-50
            {
                UIView.animate(withDuration: 0.25, delay: 0.0, options:UIView.AnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y-(editingTextFieldY-(keyboardY-100)), width: self.view.bounds.width, height: self.view.bounds.height )
                })
            }
        }
    }
    
    @objc func keyboardHidden(notification: Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options:UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height )
                })
    }
    
    
    //MARK: Actions
    @IBAction func doneBtnTap(_ sender: UIBarButtonItem) {
        //To end editing of textField
        self.view.endEditing(true)
        
        guard let firstname = firstTxtFld.text, let lastname = lastTxtFld.text, let company = compTxtFld.text else{
            return
        }

        var arr = [String]()
        for val in dataModel[0].textFldData {
            if val != "" {
                arr.append(val)
            }
        }
        if firstname != "" || lastname != "" || company != "" || !arr.isEmpty{
            let newcontact = Contact(id:UUID(), firstName: firstname, lastName: lastname, Company: company, phone: arr)
            self.contactsData.create(contact: newcontact)
            addContactDelegate?.addContact(contact: newcontact)
        }
        self.dismiss(animated: true)
    }
    
    
    @IBAction func cancelBtnTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}

//MARK: TableView Extension
extension AddViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addContactCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if addContactCell - 1 == indexPath.row {
            let cell = myTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddTableViewCell
            return cell
        }
        else {
            let cell = myTblView.dequeueReusableCell(withIdentifier: "insertPhone", for: indexPath) as! InsertPhoneTableViewCell
            
            cell.inserPhnTxtFld.tag = indexPath.row
            cell.inserPhnTxtFld.delegate = self //UITextFieldDelegate
            cell.inserPhnTxtFld.text = dataModel[0].textFldData[indexPath.row]
            phnTextField = cell.inserPhnTxtFld
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if addContactCell-1 == indexPath.row {
            addContactCell+=1
            dataModel[0].textFldData.append("")
            myTblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if addContactCell-1 == indexPath.row {
            return .insert
        }else {
            return .delete
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert{
            if addContactCell-1 == indexPath.row {
                addContactCell+=1
                dataModel[0].textFldData.append("")
                myTblView.reloadData()
            }
        }
        else if editingStyle == .delete{
            self.view.endEditing(true)
            addContactCell-=1
            dataModel[0].textFldData.remove(at: indexPath.row)
            myTblView.reloadData()
        }
    }
}

//MARK: TextField Extension
extension AddViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if firstTxtFld.text != "" || lastTxtFld.text != "" || compTxtFld.text != "" || phnTextField?.text != ""{
            doneBtn.isEnabled = true
        }
        else {
            doneBtn.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != firstTxtFld && textField != lastTxtFld && textField != compTxtFld{
            let index = NSIndexPath(row: textField.tag, section: 0)
            if let _ = myTblView.cellForRow(at: index as IndexPath) as? InsertPhoneTableViewCell {
                if index.row == textField.tag{
                    dataModel[0].textFldData[textField.tag] = textField.text ?? ""
                }
            }
        }
    }
    
    //dismiss keyboard with return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
        // or
        self.view.endEditing(true)
        return true
    }
}
