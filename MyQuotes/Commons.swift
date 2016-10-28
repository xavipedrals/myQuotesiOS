//
//  Commons.swift
//  MyQuotes
//
//  Created by Xavi on 07/10/2016.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class Commons {
    
    static var quoteFont = UIFont(name: "SourceSansPro", size: 17.0)
    
    static func heightForLabelWithFont(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    static private func calculateRecentCellHeight(quote: String) -> CGFloat {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let labelWidth = screenWidth - (20 + 20) //extract space occupied by constraints
        let height = heightForLabelWithFont(text: quote, font: quoteFont!, width: labelWidth)
        let customHeight = height + 25 + 30 + 45 //add top and bottom space
        return customHeight
    }
}
