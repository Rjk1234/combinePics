//
//  ViewController.swift
//  combinePics
//
//  Created by Rajveer Kaur on 18/10/22.
//

import UIKit
import Combine


class ViewController: UIViewController {
    
    var cancellable : AnyCancellable?
    @IBOutlet weak var tblImageList: UITableView!
    var imageList = ImageModel()
    var vm = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancellable = vm.imageResult.sink { completion in
            switch completion {
            case .failure(let err):
                print(err.localizedDescription)
            case .finished:
                print("do stuff")
            }
        } receiveValue: { list in
            print(list)
            self.tblImageList.reloadData()
        }
        vm.getImageList()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.picList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)as! imageCell
        let obj = vm.picList[indexPath.row]
        cell.imageObj = obj
        cell.setUI()
        return cell
    }
    
   
    
    
}


