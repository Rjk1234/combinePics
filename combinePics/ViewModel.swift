//
//  ViewModel.swift
//  combinePics
//
//  Created by Rajveer Kaur on 23/10/22.
//

import UIKit
import Combine

class ViewModel: ObservableObject {

    @Published var picList = ImageModel()
    var cancellable : AnyCancellable?
    let imageResult = PassthroughSubject<Void, Error>()
    
    func getImageList(){
        let url = URL(string: list)!
        let res: Resource<ImageModel> = Resource(url: url)
        cancellable = APIClient().fetch(res: res).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let err):
                self.imageResult.send(completion: .failure(err))
            case .finished:
                self.imageResult.send()
            }
        }, receiveValue: { list in
            self.picList = list
        })
    }
}
