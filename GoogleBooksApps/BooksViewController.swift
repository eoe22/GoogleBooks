//
//  ViewController.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/10/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BooksViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "bookCell"
    
    var books: [Book] = []
    
    let vm = BooksViewModel()
    
    let service = NetworkService()
    let realmService = RealmService()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        
        searchBar.delegate = self
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        //find the cell that was double tapped
        let collectionViewCell: CGPoint = sender.location(in: self.collectionView)
        
        guard let indexPath: IndexPath = self.collectionView.indexPathForItem(at: collectionViewCell)
            else { return }
        
        let book = self.books[indexPath.row]
        realmService.makeFavorite(book: book)
    }
}


extension BooksViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text else {return}
        
        self.title = "Search for \"" + query + "\""
        self.view.endEditing(true)
        
        service.searchNetwork(for: query) { books in
            self.books = books
            print(books)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension BooksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookCollectionViewCell
        
        let book = books[indexPath.row]
        
        cell.configure(with: book)
        
        return cell
    }
}

extension BooksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.collectionView.frame.size.width
        
        return CGSize(width: screenWidth/3.0,
                      height: screenWidth/3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
