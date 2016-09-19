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
    
    static let getRecentUrl = "https://myquotesserver.herokuapp.com/api/quotes/recent"
    
    static func getRecentQuotes(_ completion: @escaping (_ result: NSMutableArray) -> Void){
        Alamofire.request(getRecentUrl)
            .responseJSON { response in
                
                guard let JSON = response.result.value as? NSArray else{
                    print("Error with JSON as Array")
                    return
                }
                let quotesArray = NSMutableArray()
                for (_, element) in JSON.enumerated() {
                    guard let quoteDict = element as? NSDictionary else{
                        print("Error converting quote to dict")
                        return
                    }
                    let newQuote = Quote(data: quoteDict)
                    //newQuote.printQuote()
                    quotesArray.add(newQuote)
                }
                completion(quotesArray)
        }
    }
    
    static func getRecentQuotesWithSkip(_ skip: Int, completion: @escaping (_ result: NSMutableArray) -> Void){
        Alamofire.request(getRecentUrl, parameters: ["skip": skip])
            .responseJSON { response in
                
                guard let JSON = response.result.value as? NSArray else{
                    print("Error with JSON as Array")
                    return
                }
                let quotesArray = NSMutableArray()
                for (_, element) in JSON.enumerated() {
                    guard let quoteDict = element as? NSDictionary else{
                        print("Error converting quote to dict")
                        return
                    }
                    let newQuote = Quote(data: quoteDict)
                    //newQuote.printQuote()
                    quotesArray.add(newQuote)
                }
                completion(quotesArray)
        }
    }
}
