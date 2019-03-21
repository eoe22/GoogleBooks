
//
//  NetworkService.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/10/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import Foundation
import Alamofire
import Unbox


//MARK: SERVICE
class NetworkService {
    
    private let baseURL = "https://www.googleapis.com/books/v1/volumes?q="
    
    typealias CompletionHandler = ([Book]) -> ()
    
    func searchNetwork(for text: String, completion: @escaping CompletionHandler) {
        let url = baseURL + text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        Alamofire.request(url).responseJSON() { response in
            guard let value = response.result.value
                else {
                    completion([])
                    return
            }
            
            let dict = value as! [String: Any]
            
            guard let books : [Book] = try? unbox(dictionary: dict, atKey:"items")
                else { return }
            completion(books)
        }
    }
    
}
