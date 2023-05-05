//
//  InsertPhoneTableViewCell.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 03/03/23.
//

import UIKit

class InsertPhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileBtn: UIButton!
    
    @IBOutlet weak var inserPhnTxtFld: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
