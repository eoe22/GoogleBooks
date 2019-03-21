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
    
    func configure(with viewModel: BookCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        publisherLabel.text = viewModel.publisher
        authorLabel.text = viewModel.author
//        imageView.image = viewModel.thumbnail.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        publisherLabel.text = nil
        authorLabel.text = nil
        imageView.image = nil
    }
}
