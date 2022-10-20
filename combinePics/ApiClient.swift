//
//  ApiClient.swift
//  combinePics
//
//  Created by Rajveer Kaur on 18/10/22.
//


var list = "https://picsum.photos/v2/list"
var pagedlist = "https://picsum.photos/v2/list?page=2&limit=18"

import Foundation
import Combine

enum NetworkError: Error{
    case decodeError
    case domainError
    case urlError
    case sessionError
}

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HTTPMethod = .get
    var body: Data? = nil
    //    let headers = [
    //        "X-RapidAPI-Host": apiHost,
    //        "X-RapidAPI-Key": apiKey
    //    ]
}

extension Resource {
    init(url:URL){
        self.url = url
    }
}

typealias dataCompletionHandler = (Data?, URLResponse?, Error?) -> Void

class APIClient {
    
    func fetch<T>(res:Resource<T>)->AnyPublisher<T,Error>{
        return URLSession.shared.dataTaskPublisher(for: res.url)
            .map {$0.data}
            .decode(type: T.self, decoder: JSONDecoder() )
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}


