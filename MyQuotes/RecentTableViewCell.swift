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
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var backgroundImageHeight: NSLayoutConstraint!
    
    var userHasLiked: Bool?
//    var quoteFont = UIFont(name: "Helvetica Neue", size: 17.0)
//    var authorFont = UIFont(name: "Helvetica Neue", size: 16.0)
    
    //HELPER
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//    func setImageHeight(text: String) {
//        let screenWidth = UIScreen.main.bounds.height
//        let quoteWidth = screenWidth - (20 + 20)
//        let quoteHeight = Commons.heightForLabelWithFont(text: text, font: quoteFont!, width: quoteWidth)
//        let authorHeight = Commons.heightForLabelWithFont(text: author, font: authorFont!, width: quoteWidth)
//        let finalHeight = quoteHeight + 25 + 25 + 40
//        print(finalHeight)
//        backgroundImageHeight.constant = finalHeight
//        backgroundImage.setNeedsLayout()
//        backgroundImage.layoutSubviews()
//    }
    
    func initCell(fromQuote: Quote) {
//        setImageHeight(text: fromQuote.text!)
        backgroundImage.layer.backgroundColor = hexStringToUIColor(fromQuote.backgroundColor!).cgColor
        backgroundImage.kf_setImage(with: URL(string: fromQuote.backgroundImg!)!)
        authorLabel.text = fromQuote.authorName!
        quoteLabel.text = fromQuote.text!
//        likeImageView.image = UIImage(named: "like")
//        likeLabel.text = String(fromQuote.likeCount!)
//        userHasLiked = false
    }

    @IBAction func likePressed(_ sender: AnyObject) {
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
