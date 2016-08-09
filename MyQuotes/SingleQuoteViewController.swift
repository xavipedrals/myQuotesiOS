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
    
    var quoteStr: String?
    var authorStr: String?
    var backgroundImgStr: String?
    var authorImgStr: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
//        let backButtonItem = UIBarButtonItem(image: UIImage(named: "left-arrow"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
//        self.navigationItem.leftBarButtonItem = backButtonItem
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        roundImageView.layer.cornerRadius = roundImageView.frame.size.width / 2
        roundImageView.clipsToBounds = true
        roundImageView.layer.borderWidth = 2
        roundImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        backgroundImage.kf_setImageWithURL(NSURL(string: self.backgroundImgStr!)!)
        roundImageView.kf_setImageWithURL(NSURL(string: self.authorImgStr!)!)
        self.authorLabel.text = self.authorStr!
        self.quoteLabel.text = self.quoteStr!
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
