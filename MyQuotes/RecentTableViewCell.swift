//
//  RecentTableViewCell.swift
//  MyQuotes
//
//  Created by Xavi on 30/07/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit
import Kingfisher

class RecentTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    var quoteBackground: String?
    var quote: String?
    var author: String?
    var userHasLiked: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        if (self.userHasLiked != nil && self.userHasLiked!){
//            likeImageView.image = UIImage(named: "like")
//        }
        
//        self.backgroundImage.kf_setImageWithURL(NSURL(string: "https://images.unsplash.com/photo-1422651355218-53453822ebb8?w=600&fit=max")!)
//
//        self.backgroundImage.layer.cornerRadius = 15
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likePressed(sender: AnyObject) {
        if (self.userHasLiked!){
            self.likeImageView.image = UIImage(named: "like")
            self.userHasLiked = false
            var likeCount = Int(self.likeLabel.text!)!
            likeCount -= 1
            self.likeLabel.text = String(likeCount)
            
        }
        else {
            self.likeImageView.image = UIImage(named: "like-red")
            self.userHasLiked = true
            var likeCount = Int(self.likeLabel.text!)!
            likeCount += 1
            self.likeLabel.text = String(likeCount)
        }
    }
}
