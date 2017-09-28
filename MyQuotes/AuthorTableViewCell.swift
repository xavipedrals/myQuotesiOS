//
//  AuthorTableViewCell.swift
//  MyQuotes
//
//  Created by Xavi on 19/09/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit
import Kingfisher

class AuthorTableViewCell: UITableViewCell {

    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quotesNumberLabel: UILabel!
    @IBOutlet weak var authorPhotoHeight: NSLayoutConstraint!
    
    func setAuthorName(name: String) {
        nameLabel.text = name
    }

    func setQuotesNumber(numQuotes: Int) {
        quotesNumberLabel.text = String(numQuotes) + " quotes"
    }
    
    func setAuthorPhoto(fromUrl: String) {
        authorPhoto.layer.cornerRadius = authorPhotoHeight.constant / 2
        authorPhoto.clipsToBounds = true
        authorPhoto.kf.setImage(with: URL(string: fromUrl), placeholder: UIImage(named: "user-black-line"))
    }
}
