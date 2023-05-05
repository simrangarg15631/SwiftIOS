//
//  InsertPhoneTableViewCell.swift
//  ContactsApp
//
//  Created by Simran Garg on 03/03/23.
//

import UIKit

class InsertPhoneTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var mobileBtn: UIButton!
    
    @IBOutlet weak var inserPhnTxtFld: UITextField!
    
    //MARK: Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
