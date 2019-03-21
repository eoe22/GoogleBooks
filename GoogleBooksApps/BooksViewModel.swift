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
    var dataLoadedCallback: (() -> ())?
    
    var numberOfRows: Int {
        return books.count
    }
    
    init() {}
    
    func modelForCell(at indexPath: IndexPath) -> BookCollectionViewCellViewModel {
        return BookCollectionViewCellViewModel(book: books[indexPath.row])
    }
    
    func fetchBooks(for text: String) {
        service.searchNetwork(for: text) { [weak self] books in
            self?.books = books
            self?.dataLoadedCallback?()
        }
    }
}
