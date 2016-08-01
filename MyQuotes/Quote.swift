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
    var author: String?
    var authorBackground: String?
    var quote: String?
    var quoteBackground: String?
    
    init(data: NSDictionary) {
        guard let id = data["_id"] as? String else{
            print("Error with id")
            return
        }
        guard let author = data["author"] as? String else{
            print("Error with author")
            return
        }
        guard let authorBackground = data["authorBackground"] as? String else{
            print("Error with authorBackground")
            return
        }
        guard let quote = data["quote"] as? String else{
            print("Error with quote")
            return
        }
        guard let quoteBackground = data["background"] as? String else{
            print("Error with background")
            return
        }
        
        self.id = id
        self.author = author
        self.authorBackground = authorBackground
        self.quote = quote
        self.quoteBackground = quoteBackground
    }
    
    func printQuote(){
        print("id " + self.id!)
        print("author " + self.author!)
        print("authorBackground " + self.authorBackground!)
        print("quote " + self.quote!)
        print("quoteBackground " + self.quoteBackground!)
    }

}
