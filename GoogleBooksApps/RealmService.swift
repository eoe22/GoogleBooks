//
//  RealmService.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/17/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    func makeFavorite(book: Book) {
        DispatchQueue.global(qos: .utility).async {
            RealmRepository.create(using: book)
        }
    }
    
    func getRepository(completion: @escaping ([Book]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let realm = try! Realm()
            let objects = realm.objects(RealmBook.self)
            let result = Array(objects.map { x in
                return Book(with: x)
            })
            completion(result)
        }
    }
    
    typealias Handler = () -> ()
    func removeBook(book: Book, completion: @escaping Handler) {
        DispatchQueue.global(qos: .utility).async {
            RealmRepository.remove(using: book)
            completion()
        }
    }
    
//    func deleteAll(){
//        DispatchQueue.global(qos: .utility).async {
//            RealmRepository.removeAll()
//        }
//    }
}
