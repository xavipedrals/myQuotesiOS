//
//  NetworkController.swift
//  MyQuotes
//
//  Created by Xavi on 01/08/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit
import Alamofire

class NetworkController: NSObject {
    
    static let getRecentUrl = "http://localhost:9000/api/quotes/recent"
    
    static func getRecentQuotes(completion: (result: NSMutableArray) -> Void){
        Alamofire.request(.GET, getRecentUrl)
            .responseJSON { response in
                
                guard let JSON = response.result.value as? NSArray else{
                    print("Error with JSON as Array")
                    return
                }
                let quotesArray = NSMutableArray()
                for (_, element) in JSON.enumerate() {
                    guard let quoteDict = element as? NSDictionary else{
                        print("Error converting quote to dict")
                        return
                    }
                    let newQuote = Quote(data: quoteDict)
                    //newQuote.printQuote()
                    quotesArray.addObject(newQuote)
                }
                completion(result: quotesArray)
        }
    }
    
    static func getRecentQuotesWithSkip(skip: Int, completion: (result: NSMutableArray) -> Void){
        Alamofire.request(.GET, getRecentUrl, parameters: ["skip": skip])
            .responseJSON { response in
                
                guard let JSON = response.result.value as? NSArray else{
                    print("Error with JSON as Array")
                    return
                }
                let quotesArray = NSMutableArray()
                for (_, element) in JSON.enumerate() {
                    guard let quoteDict = element as? NSDictionary else{
                        print("Error converting quote to dict")
                        return
                    }
                    let newQuote = Quote(data: quoteDict)
                    //newQuote.printQuote()
                    quotesArray.addObject(newQuote)
                }
                completion(result: quotesArray)
        }
    }
}
