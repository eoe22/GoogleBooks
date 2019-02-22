//
//  BookCollectionViewCell.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 1/14/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import UIKit
import SDWebImage

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func configure(with book: Book) {
        titleLabel.text = book.title
        publisherLabel.text = book.publisher ?? "Not Available"
        authorLabel.text = book.author?.joined(separator: ", ")
        
        let url = book.thumbnail?.replacingOccurrences(of: "http", with: "https")
        
        if (book.thumbnail == nil) {
            imageView.image = #imageLiteral(resourceName: "No_Image_Available")
        }
        else {
        imageView.sd_setImage(
            with: URL(string: url!),
            placeholderImage: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
