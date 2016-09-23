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
    func updateQuoteLikes(_ idQuote: String, likeCount: Int)
}

class SingleQuoteViewController: UIViewController {

    @IBOutlet weak var roundImageView: UIImageView!
    @IBOutlet weak var roundImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var doubleClickView: UIView!
    @IBOutlet weak var bigLikeImageView: UIImageView!
    
    var quoteStr: String?
    var authorStr: String?
    var backgroundImgStr: String?
    var authorImgStr: String?
    var likeCount: Int?
    var userHasLiked: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVisuals()
        configDoubleTapGestureRecognizer()
    }
    
    func initVisuals() {
        configNavigationBar()
        roundImageView.layer.cornerRadius = roundImageViewHeight.constant / 2
        roundImageView.clipsToBounds = true
        roundImageView.layer.borderWidth = 1
        roundImageView.layer.borderColor = UIColor.white.cgColor
        
        backgroundImage.kf_setImage(with: URL(string: self.backgroundImgStr!)!)
        roundImageView.kf_setImage(with: URL(string: self.authorImgStr!)!, placeholder: UIImage(named: "user.png"))
        authorLabel.text = authorStr!
        quoteLabel.text = quoteStr!
        likeLabel.text = String(likeCount!)
    }
    
    func configNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func configDoubleTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        doubleClickView.addGestureRecognizer(tap)
    }
    
    func doubleTapped() {
        BigLikeAnimation.start(likeView: self.bigLikeImageView)
        if (!userHasLiked!) {
            changeLikeState()
        }
        SmallLikeAnimation.start(likeView: self.likeImageView)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func likePressed(_ sender: AnyObject) {
        changeLikeState()
    }
    
    func changeLikeState() {
        var likeCount = Int(self.likeLabel.text!)!
        if (userHasLiked!){
            likeImageView.image = UIImage(named: "like")
            userHasLiked = false
            likeCount -= 1
        }
        else {
            likeImageView.image = UIImage(named: "like-red")
            userHasLiked = true
            likeCount += 1
        }
        likeLabel.text = String(likeCount)
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
