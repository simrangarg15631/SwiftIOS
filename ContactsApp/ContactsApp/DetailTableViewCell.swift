//
//  DetailTableViewCell.swift
//  ContactsApp
//
//  Created by Saheem Hussain on 02/03/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileLbl: UILabel!
    
    @IBOutlet weak var phnLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
