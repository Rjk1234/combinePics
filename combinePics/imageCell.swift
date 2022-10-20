//
//  imageCell.swift
//  combinePics
//
//  Created by Rajveer Kaur on 18/10/22.
//

import UIKit

class imageCell: UITableViewCell {
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var lblAuthor:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
