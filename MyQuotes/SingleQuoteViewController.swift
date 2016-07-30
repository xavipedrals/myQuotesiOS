//
//  SingleQuoteViewController.swift
//  MyQuotes
//
//  Created by Xavi on 30/07/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit
import Kingfisher

class SingleQuoteViewController: UIViewController {

    @IBOutlet weak var roundImageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        roundImageView.layer.cornerRadius = roundImageView.frame.size.width / 2
        roundImageView.clipsToBounds = true
        roundImageView.layer.borderWidth = 3
        roundImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        backgroundImage.kf_setImageWithURL(NSURL(string: "https://images.unsplash.com/photo-1422651355218-53453822ebb8?w=600&fit=max")!)
        roundImageView.kf_setImageWithURL(NSURL(string: "https://pbs.twimg.com/profile_images/571442793/winston-churchill.jpg")!)
    }
}
