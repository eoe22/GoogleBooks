//
//  BooksViewModel.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/12/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BooksViewModel{
    
    var faveBooks = Variable<[Book]>([])
    
    let service = NetworkService()
    let realmService = RealmService()
    
    init() {
    }
    
    func search(for text: String){
        
    }
}
