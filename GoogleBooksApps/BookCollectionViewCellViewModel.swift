//
//  BookCollectionViewCellViewModel.swift
//  GoogleBooksApps
//
//  Created by C2QJG01SDRJD on 3/20/19.
//  Copyright © 2019 C2QJG01SDRJD. All rights reserved.
//

import Foundation
import SDWebImage

struct BookCollectionViewCellViewModel {
    let book: Book
    
    var title: String {
        return book.title
    }
    
    var publisher: String {
        return book.publisher ?? "Publisher Not Available"
    }
    
    var author: String {
        return book.author?.joined(separator: ", ") ?? "Author Not Available"
    }
    
//    var thumbnail: UIImageView {
//        let url = book.thumbnail?.replacingOccurrences(of: "http", with: "https")
//        
//        if (book.thumbnail == nil){
//            self.thumbnail.image = #imageLiteral(resourceName: "No_Image_Available")
//        }
//        else{
//            self.thumbnail.sd_setImage(with: URL(string: url!), placeholderImage: nil)
//        }
//        return self.thumbnail
//    }
}
