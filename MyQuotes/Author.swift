//
//  Author.swift
//  MyQuotes
//
//  Created by Xavi on 19/09/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class Author: NSObject {

    var id: String?
    var name: String?
    var photo: String?
    var quotesCount: Int?
    
    init(data: NSDictionary) {
        guard let id = data["_id"] as? String else{
            print("Error with id")
            return
        }
        guard let name = data["name"] as? String else{
            print("Error with name")
            return
        }
        guard let photo = data["photo"] as? String else{
            print("Error with photo")
            return
        }
        guard let quotesCount = data["quotes_count"] as? Int else{
            print("Error with quotes_count")
            return
        }
        
        self.id = id
        self.name = name
        self.photo = photo
        self.quotesCount = quotesCount
    }
}
