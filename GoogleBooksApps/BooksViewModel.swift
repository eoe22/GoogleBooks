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
    
    var books: [Book] = []
    let service = NetworkService()
    
    var numberOfRows: Int {
        return books.count
    }
    
    init() {}
    
//    func modelForCell(at indexPath: IndexPath) -> BookCollectionViewCell
}
