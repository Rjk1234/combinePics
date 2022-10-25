//
//  VCLoginViewController.swift
//  combinePics
//
//  Created by Rajveer Kaur on 25/10/22.
//

import UIKit
import Combine


class VCLoginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnPub: UIButton!
    @IBOutlet weak var lblSub: UILabel!
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($email, $password)
            .map{ email, password in
                return !email.isEmpty && !password.isEmpty && password.count >= 6
            }.eraseToAnyPublisher()
    }
    var cancelable : AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelable = validToSubmit.receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: btnPub)
    }
    @IBAction func onEMailChange(_ sender: UITextField){
        email = sender.text ?? ""
    }
    @IBAction func onPWChange(_ sender: UITextField){
        password = sender.text ?? ""
    }
    @IBAction func onTap(_ sender: UIButton){
    }
    
}
