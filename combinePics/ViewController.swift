//
//  ViewController.swift
//  combinePics
//
//  Created by Rajveer Kaur on 18/10/22.
//

import UIKit
import Combine
import SDWebImage

class ViewController: UIViewController {
    
    var cancellable : AnyCancellable?
    @IBOutlet weak var tblImageList: UITableView!
    var imageList = ImageModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: list)!
        let res: Resource<ImageModel> = Resource(url: url)
        cancellable = APIClient().fetch(res: res).sink(receiveCompletion: { result in
            print(result)
        }, receiveValue: { list in
            print(list.count)
            print(list)
            self.imageList = list
            self.tblImageList.reloadData()
        })
        
        
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)as! imageCell
        let obj = imageList[indexPath.row]
        
        
        if let strurl = obj.downloadURL as? String {
            let url = URL(string: strurl)!
            print(url)
            cell.img.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            cell.img.layer.cornerRadius = 5
        }
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(onTapFav), for: .touchUpInside)
        cell.lblAuthor.text = obj.author
        return cell
    }
    
    @objc func onTapFav(_ sender: UIButton)
    {
        print(sender.tag)
        
    }
    
    
}


