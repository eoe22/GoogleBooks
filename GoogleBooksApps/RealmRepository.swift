//
//  RealmRepository.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/17/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import Foundation
import RealmSwift

class RealmBook: Object {
    
    //creates a unique ID
    @objc dynamic var bookID = ""
    @objc dynamic var title: String = ""
    @objc dynamic var publisher: String? = ""
    @objc dynamic var thumbnail: String? = nil
    
    var authors = List<RealmAuthor>()
    
    override static func primaryKey() -> String? {
        return "bookID"
    }
}

class RealmAuthor: Object {
    @objc dynamic var author: String? = ""
}

class RealmRepository {
    
    static func create(using repo: Book) {
        
        // ADD / UPDATE - ASSIGN OBJECTS INTO DICT
        //better implementation so no objects are null
//        var realmBooks = ["bookID": "My-Primary-Key",
//                          "title": repo.title,
//                          "thumbnail": repo.thumbnail ?? "",
//                          "publisher": [repo.author]]
        
        // ADD/UPDATE - ASSIGN OBJECTS ONE BY ONE
        //objects that are not assigned will become null
        let realmBook = RealmBook()
        realmBook.bookID = repo.bookID
        realmBook.title = repo.title
        realmBook.publisher = repo.publisher
        realmBook.thumbnail = repo.thumbnail
        
        let realm  = try! Realm()
        try! realm.write {
            if (repo.author != nil) {
                for x in repo.author! {
                    
                    let realmAuthor = RealmAuthor()
                    realmAuthor.author = x
                    realmBook.authors.append(realmAuthor)
                    
                    //APPEND TO REALMBOOKS INSTEAD
                    //realm.add(realmAuthor)
                }
            }
            realm.add(realmBook, update: true)
        }
    }
    
    static func remove(using repo: Book) {
        let realm = try! Realm()
        let realmBook = realm.object(ofType: RealmBook.self, forPrimaryKey: repo.bookID)
        try! realm.write {
            realm.delete(realmBook!)
        }
    }
    
//    static func removeAll(){
//        let realm = try! Realm()
//        
//        try! realm.write{
//            realm.deleteAll()
//        }
//    }
}
