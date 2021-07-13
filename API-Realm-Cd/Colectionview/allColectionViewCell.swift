//
//  allColectionViewCell.swift
//  API-Realm-Cd
//
//  Created by phamtu on 13/07/2021.
//

import UIKit

class allColectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblspecies: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lnlname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

}
