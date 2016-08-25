//
//  Quote.swift
//  MyQuotes
//
//  Created by Xavi on 01/08/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class Quote: NSObject {
    
    var id: String?
    var likeCount: Int?
    var authorName: String?
    var authorPhoto: String?
    var text: String?
    var backgroundImg: String?
    var backgroundColor: String?
    
    init(data: NSDictionary) {
        guard let id = data["_id"] as? String else{
            print("Error with id")
            return
        }
        guard let authorName = data["author_name"] as? String else{
            print("Error with author_name")
            return
        }
        guard let authorPhoto = data["author_photo"] as? String else{
            print("Error with author_photo")
            return
        }
        guard let text = data["text"] as? String else{
            print("Error with text")
            return
        }
        guard let backgroundImg = data["background_img"] as? String else{
            print("Error with background_img")
            return
        }
        guard let backgroundColor = data["background_color"] as? String else{
            print("Error with background_color")
            return
        }
        guard let likeCount = data["like_count"] as? Int else{
            print("Error with like_count")
            return
        }
        
        self.id = id
        self.authorName = authorName
        self.authorPhoto = authorPhoto
        self.text = text
        self.backgroundImg = backgroundImg
        self.backgroundColor = backgroundColor
        self.likeCount = likeCount
    }
    
    func printQuote(){
        print("id " + self.id!)
        print("likeCount " + String(self.likeCount!))
        print("authorName " + self.authorName!)
        print("authorPhoto " + self.authorPhoto!)
        print("text " + self.text!)
        print("backgroundImg " + self.backgroundImg!)
        print("backgroundColor " + self.backgroundColor!)
    }

}
