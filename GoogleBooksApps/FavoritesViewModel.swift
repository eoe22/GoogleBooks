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
    var numberOfSections: Int = 1
    
    var numberOfRows: Int {
        return books.count
    }
    
    init() {}
    
    func modelForCellFave(at indexPath: IndexPath) -> BookCollectionViewCellViewModel {
        return BookCollectionViewCellViewModel(book: books[indexPath.row])
    }
    
    func fetchRealmBooks() {
        realmService.getRepository() { [weak self] books in
            self?.books = books
            self?.dataLoadedCallback?()
        }
    }
    
    func callRemove(book: Book) {
        realmService.removeBook(book: book) {
            self.fetchRealmBooks()
        }
    }
}
