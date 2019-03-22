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
    let vm = BooksViewModel()
    let realmService = RealmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        vm.dataLoadedCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
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
        
        let book = vm.books[indexPath.row]
        vm.favorite(book: book)
    }
}


extension BooksViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text else {return}
        
        self.title = "Search for \"" + query + "\""
        self.view.endEditing(true)
        
        vm.fetchBooks(for: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension BooksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookCollectionViewCell
        
        cell.configure(with: vm.modelForCell(at: indexPath))
        
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
