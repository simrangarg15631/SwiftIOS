//
//  EditViewController.swift
//  ContactsApp
//
//  Created by Simran Garg on 28/02/23.
//

import UIKit

class EditViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var firstNameTxtFld: UITextField!
    
    @IBOutlet weak var lastNamTxtFld: UITextField!
    
    @IBOutlet weak var CompTxtFld: UITextField!
    
    @IBOutlet weak var tablView: UITableView!
    
    //MARK: Properties
    private let contactsData = ContactRepository()
    var contact:Contact? = nil
    var strid:UUID!
    
    var dataModel = [TextFieldModel]()
    var activeTextField:UITextField!
    
    var editContactCell:Int!
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contact = contactsData.get(byIdentifier: strid)

        firstNameTxtFld.text = contact?.firstName ?? ""
        lastNamTxtFld.text = contact?.lastName ?? ""
        CompTxtFld.text = contact?.Company ?? ""
        
        editContactCell = (contact?.phone.count ?? 0) + 1
        
        tablView.isEditing = true
        tablView.allowsSelectionDuringEditing = true
        
        dataModel.append(TextFieldModel(textData: contact?.phone ?? [""]))
        
        self.navigationItem.title = "Edit Contact"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnAction))
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        [firstNameTxtFld,lastNamTxtFld,CompTxtFld].forEach({$0?.addTarget(self, action: #selector(textEditing), for: .editingChanged)})
        
        //Keyboard Handling
        firstNameTxtFld.delegate = self
        lastNamTxtFld.delegate = self
        CompTxtFld.delegate = self
        
        self.hideKeyBoardTappedAround()
        
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func textEditing(_ textfield: UITextField){
        if textfield == firstNameTxtFld && textfield.text == contact?.firstName {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else if textfield == lastNamTxtFld && textfield.text == contact?.lastName {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else if textfield == CompTxtFld && textfield.text == contact?.Company{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else{
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    //Done button
    @objc func doneBtnAction() {
        
        self.view.endEditing(true)
        
        var arr = [String]()
        for val in dataModel[0].textFldData {
            if val != "" {
                arr.append(val)
            }
        }
        if firstNameTxtFld.text != "" || lastNamTxtFld.text != "" || CompTxtFld.text != "" || !arr.isEmpty{
            let updatedContact = Contact(id:strid, firstName: firstNameTxtFld.text!, lastName: lastNamTxtFld.text!, Company: CompTxtFld.text!, phone: arr)
            self.contactsData.update(contact: updatedContact)
        }
        self.navigationController?.popViewController(animated: true)
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
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y-(editingTextFieldY-(keyboardY-50)), width: self.view.bounds.width, height: self.view.bounds.height )
                })
            }
        }
    }
    
    
    @objc func keyboardHidden(notification: Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options:UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height )
                })
    }
    
 
    //MARK: Action
    @IBAction func deleteBtn(_ sender: UIButton) {
        //Action Sheet
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(sheet, animated: true, completion: nil)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteBtn = UIAlertAction(title: "Delete Contact", style: .destructive){ (action) in
            self.contactsData.delete(id: self.strid)
            self.navigationController?.popToRootViewController(animated: true)
        }
        sheet.addAction(deleteBtn)
        sheet.addAction(cancelBtn)
    }
}

//MARK: TableView Extension
extension EditViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editContactCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if editContactCell - 1 == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditTableViewCell
            return cell
        }
        else{
            
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditPhoneTableViewCell
            cell.PhoneTXTFLd.tag = indexPath.row
            cell.PhoneTXTFLd.delegate = self
                cell.PhoneTXTFLd.text = dataModel[0].textFldData[indexPath.row]

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if editContactCell-1 == indexPath.row {
            editContactCell+=1
            dataModel[0].textFldData.append("")
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if editContactCell-1 == indexPath.row{
            return .insert
        }else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
            if editingStyle == .insert{
                if editContactCell-1 == indexPath.row {
                    editContactCell+=1
                    dataModel[0].textFldData.append("")
                    tableView.reloadData()
                }
            }
            else if editingStyle == .delete{
                self.view.endEditing(true)
                editContactCell-=1
                dataModel[0].textFldData.remove(at: indexPath.row)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                tableView.reloadData()
            }
        }
}

//MARK: Textfield Extension
extension EditViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    //to enable done btn
    func textFieldDidChangeSelection(_ textField: UITextField) {
      
        if textField != firstNameTxtFld && textField != lastNamTxtFld && textField != CompTxtFld{
            if (textField.text == dataModel[0].textFldData[textField.tag] || textField.text == "") {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            else{
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
        else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    //store phone nos in dataModel
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != firstNameTxtFld && textField != lastNamTxtFld && textField != CompTxtFld{
            let index = NSIndexPath(row: textField.tag, section: 0)
            if let _ = tablView.cellForRow(at: index as IndexPath) as? EditPhoneTableViewCell {
                if index.row == textField.tag{
                    dataModel[0].textFldData[textField.tag] = textField.text ?? ""
                }
            }
        }
    }
    
    //dismiss keyboard with return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        // or
//        self.view.endEditing(true)
        return true
    }
    
   
}
