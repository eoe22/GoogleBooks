//
//  FavoritesViewController.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/26/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "bookCell"
    let realmService = RealmService()
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getBooks()
//        realmService.deleteAll()
    }
    
    func getBooks() {
        realmService.getRepository() { books in
            self.books = books
            print(books)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func removeAsFavorite(_ sender: UITapGestureRecognizer) {
        
        let collectionViewCell: CGPoint = sender.location(in: self.collectionView)
        
        guard let indexPath: IndexPath = self.collectionView.indexPathForItem(at: collectionViewCell)
            else { return }
        
        let book = self.books[indexPath.row]
        realmService.removeBook(book: book){ x in
            self.getBooks()
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookCollectionViewCell
        
        //Make VM
//        let book = books[indexPath.row]
//        cell.configure(with: book)
        
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = self.collectionView.frame.size.width
        
        return CGSize(width: screenWidth/3.0,
                      height: screenWidth/3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
}
