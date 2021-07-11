//
//  Charactercell.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class Charactercell: UITableViewCell {

    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellview.layer.borderWidth = 0.3
        cellview.layer.borderColor = UIColor.red.cgColor
        cellview.layer.cornerRadius = 5
        cellview.layer.masksToBounds = true
        self.contentView.frame  = cellview.frame
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
