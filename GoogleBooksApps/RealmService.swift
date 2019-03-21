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
    
    func makeFavorite(book: Book){
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
}

class RealmRepository {
    
    static func create(using repo: Book) {
        let realmBook = RealmBook()
        realmBook.bookID = repo.bookID
        realmBook.title = repo.title
        realmBook.publisher = repo.publisher
        realmBook.thumbnail = repo.thumbnail
        
        let realm  = try! Realm()
        try! realm.write {
            
            if (repo.author != nil) {
                
                for x in repo.author!{
                    
                    let realmAuthor = RealmAuthor()
                    
                    realmAuthor.author = x
                    
                    realmBook.authors.append(realmAuthor)
                }
            }
            
            realm.add(realmBook, update: true)
        }
    }
    
    static func remove(using repo: Book) {
        
        let realm = try! Realm()
        
        let realmBook = realm.object(ofType: RealmBook.self, forPrimaryKey: repo.bookID)
        
        try! realm.write{
            realm.delete(realmBook!)
        }
    }
}
