//
//  ViewControllerSignUP.swift
//  combinePics
//
//  Created by Rajveer Kaur on 25/10/22.
//

import UIKit
import Combine

class ViewControllerSignUP: UIViewController {
    @IBOutlet weak var tfUserNAme: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRepeatPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    var cancellable : AnyCancellable?
    
    var validUserName: AnyPublisher<Bool, Never> {
        return $name
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap{ name in
                return Future {promise in
                    self.usernameAvailable(name){available in
                        promise(.success(available ? true : false))
                    }
                }
            }.eraseToAnyPublisher()
    }
    var validPassword: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($password, $repeatPassword)
            .map{passwordOne, passwordTwo in
                return !passwordOne.isEmpty && !passwordTwo.isEmpty && passwordOne == passwordTwo
            }.eraseToAnyPublisher()
    }
    var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validUserName, validPassword)
            .receive(on: RunLoop.main)
            .map{ name, password in
                return name && password
            }.eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancellable = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: btnSubmit)
    }
    func usernameAvailable(_ username: String, completion: (Bool) -> Void) {
        completion(true) // fake asynchronous backend service
    }
    
    
}
// MARK: - UITextFieldDelegate
extension ViewControllerSignUP: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText = textField.text ?? ""
        let text = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == tfUserNAme { name = text }
        if textField == tfPassword { password = text }
        if textField == tfRepeatPassword { repeatPassword = text }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
