//
//  FavoritesViewModel.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 3/21/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import Foundation

class FavoritesViewModel {
    
    var books: [Book] = []
    let realmService = RealmService()
    var dataLoadedCallback: (() -> ())?
    
    var numberOfRows: Int {
        return books.count
    }
    
    init() {}
    
    func modelForCell(at indexPath: IndexPath) -> BookCollectionViewCellViewModel {
        return BookCollectionViewCellViewModel(book: books[indexPath.row])
    }
    
    func fetchBooks(for text: String) {
        realmService.getRepository() { [weak self] books in
            self?.books = books
            self?.dataLoadedCallback?()
        }
    }
}
