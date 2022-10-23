//
//  imageCell.swift
//  combinePics
//
//  Created by Rajveer Kaur on 18/10/22.
//

import UIKit
import SDWebImage

class imageCell: UITableViewCell {
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var btnFav:UIButton!
    @IBOutlet weak var lblAuthor:UILabel!
    var imageObj: ImageModelElement!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }
    
    func setUI(){
        guard let obj = imageObj else {return}
        if let strurl = obj.downloadURL as? String {
            let url = URL(string: strurl)!
            print(url)
            self.img.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            self.img.layer.cornerRadius = 5
        }
       self.lblAuthor.text = obj.author
    }

}
