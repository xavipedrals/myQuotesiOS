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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundImage.kf_setImageWithURL(NSURL(string: "https://images.unsplash.com/photo-1422651355218-53453822ebb8?w=600&fit=max")!)
        self.backgroundImage.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
