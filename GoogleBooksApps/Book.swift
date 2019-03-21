//
//  Books.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/12/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

//MARK: MODEL

struct Book {
    let bookID: String
    let title: String
    let author: [String]?
    let publisher: String?
    let thumbnail: String?
    
    init(with realmObj: RealmBook) {
        self.bookID = realmObj.bookID
        self.title = realmObj.title
        self.author = Array(realmObj.authors.flatMap{ $0.author } )
        self.publisher = realmObj.publisher
        self.thumbnail = realmObj.thumbnail
    }
}

class RealmBook: Object {
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

extension Book: Unboxable{
    
    init(unboxer: Unboxer) throws {
        self.bookID = try unboxer.unbox(key: "id")
        self.title = try unboxer.unbox(keyPath: "volumeInfo.title")
        self.author = try? unboxer.unbox(keyPath: "volumeInfo.authors")
        self.publisher = try? unboxer.unbox(keyPath: "volumeInfo.publisher")
        self.thumbnail = try? unboxer.unbox(keyPath: "volumeInfo.imageLinks.thumbnail")
    }
}
