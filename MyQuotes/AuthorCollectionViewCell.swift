//
//  AuthorCollectionViewCell.swift
//  MyQuotes
//
//  Created by Xavi on 27/09/2016.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class AuthorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quotesNumberLabel: UILabel!
    @IBOutlet weak var authorPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var textContainer: UIView!
    @IBOutlet weak var cellLeading: NSLayoutConstraint!
    @IBOutlet weak var cellTrailing: NSLayoutConstraint!
    
    func initCell(from: Author, index: Int) {
        setAuthorName(name: from.name!)
        setQuotesNumber(numQuotes: from.quotesCount!)
        setAuthorPhoto(fromUrl: from.photo!)
        textContainer.layer.cornerRadius = 5
    }
    
    func setAuthorName(name: String) {
        nameLabel.text = name
    }
    
    func setQuotesNumber(numQuotes: Int) {
        quotesNumberLabel.text = String(numQuotes) + " quotes"
    }
    
    func setAuthorPhoto(fromUrl: String) {
        authorPhoto.layer.cornerRadius = authorPhotoHeight.constant / 2
        authorPhoto.clipsToBounds = true
        authorPhoto.kf_setImage(with: URL(string: fromUrl), placeholder: UIImage(named: "user-black-line"))
    }
    
}
