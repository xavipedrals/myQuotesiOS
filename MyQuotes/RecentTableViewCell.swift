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
    
    var userHasLiked: Bool?
    
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
    
    func initCell(fromQuote: Quote) {
        backgroundImage.layer.backgroundColor = hexStringToUIColor(fromQuote.backgroundColor!).cgColor
        backgroundImage.kf_setImage(with: URL(string: fromQuote.backgroundImg!)!)
        authorLabel.text = fromQuote.authorName!
        quoteLabel.text = fromQuote.text!
        likeImageView.image = UIImage(named: "like")
        likeLabel.text = String(fromQuote.likeCount!)
        userHasLiked = false
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
