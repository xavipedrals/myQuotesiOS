//
//  SingleQuoteViewController.swift
//  MyQuotes
//
//  Created by Xavi on 30/07/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit
import Kingfisher

protocol updateQuotesArray {
    func updateQuoteLikes(idQuote: String, likeCount: Int)
}

class SingleQuoteViewController: UIViewController {

    @IBOutlet weak var roundImageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    var quoteStr: String?
    var authorStr: String?
    var backgroundImgStr: String?
    var authorImgStr: String?
    var likeCount: Int?
    var userHasLiked: Bool?
    
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
        roundImageView.layer.borderWidth = 1
        roundImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        backgroundImage.kf_setImageWithURL(NSURL(string: self.backgroundImgStr!)!)
        roundImageView.kf_setImageWithURL(NSURL(string: self.authorImgStr!)!)
        self.authorLabel.text = self.authorStr!
        self.quoteLabel.text = self.quoteStr!
        self.likeLabel.text = String(likeCount!)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
