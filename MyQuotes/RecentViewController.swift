//
//  RecentViewController.swift
//  MyQuotes
//
//  Created by Xavi on 30/07/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, updateQuotesArray {

    @IBOutlet weak var tableView: UITableView!
    var quotesArray: NSMutableArray?
    var lastSelectedIndex: Int?
    var heightAtIndexPath: NSMutableDictionary!
    var isDataRefreshing: Bool!
    var stopRefreshing: Bool!
    
    //HELPER
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight = 300
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.heightAtIndexPath = NSMutableDictionary()
        NetworkController.getRecentQuotes(){
            result in
            self.quotesArray = result
            self.tableView.reloadData()
//            self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, self.tableView.numberOfSections)), withRowAnimation: .None)
        }
        self.isDataRefreshing = false
        self.stopRefreshing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.title = "Recent"
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.lastSelectedIndex = indexPath.row
        self.performSegueWithIdentifier("showRecentDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = self.heightAtIndexPath.objectForKey(indexPath)
        if ((height) != nil) {
            return CGFloat(height!.floatValue)
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let height = cell.frame.size.height
        self.heightAtIndexPath.setObject(height, forKey: indexPath)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.quotesArray != nil){
            return (self.quotesArray?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCellWithIdentifier("recentCell") as? RecentTableViewCell{
            if let quoteObj = quotesArray![indexPath.row] as? Quote {

                cell.backgroundImage.layer.backgroundColor = hexStringToUIColor(quoteObj.backgroundColor!).CGColor
                cell.backgroundImage.kf_setImageWithURL(NSURL(string: quoteObj.backgroundImg!)!)
                cell.authorLabel.text = quoteObj.authorName!
                cell.quoteLabel.text = quoteObj.text!
                cell.likeImageView.image = UIImage(named: "like")
                cell.likeLabel.text = String(quoteObj.likeCount!)
                cell.userHasLiked = false
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let screenHeight = UIScreen.mainScreen().bounds.height
        //IPAD
        //return screenWidth * 0.55
        
        //IPHONE
        return screenHeight * 0.37
    }
    
    //when table bottom is reached get more rows
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!self.isDataRefreshing && !self.stopRefreshing){
            let height = scrollView.frame.size.height;
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if(distanceFromBottom < height)
            {
                //BOTTOM OF THE TABLE
//                print("End of the table")
                self.isDataRefreshing = true
                NetworkController.getRecentQuotesWithSkip(self.quotesArray!.count){
                    result in
                    if (result.count > 0){
                        var indexPathsArray = [NSIndexPath]()
                        for index in 0...result.count-1 {
                            let newIndex = index + self.quotesArray!.count
                            indexPathsArray.append(NSIndexPath(forRow: newIndex, inSection: 0))
                        }
                        self.quotesArray?.addObjectsFromArray(result as [AnyObject])
                        
                        self.tableView.beginUpdates()
                        self.tableView.insertRowsAtIndexPaths(indexPathsArray, withRowAnimation: .Bottom)
                        self.tableView.endUpdates()
                        
                        self.isDataRefreshing = false
                    }
                    else {
                        self.stopRefreshing = true
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRecentDetail"{
            if let detailViewController = segue.destinationViewController as? SingleQuoteViewController{
                if let quoteObj = quotesArray![lastSelectedIndex!] as? Quote{
                    detailViewController.quoteStr = quoteObj.text!
                    detailViewController.authorStr = quoteObj.authorName!
                    detailViewController.backgroundImgStr = quoteObj.backgroundImg!
                    detailViewController.authorImgStr = quoteObj.authorPhoto!
                    detailViewController.userHasLiked = false
                    detailViewController.likeCount = quoteObj.likeCount!
                }
            }
        }
    }
    
    func updateQuoteLikes(idQuote: String, likeCount: Int){
        var i = 0
        var found = false
        while (!found && i < quotesArray?.count){
            if let quote = quotesArray![i] as? Quote {
                if (quote.id == idQuote){
                    quote.likeCount = likeCount
                    found = true
                }
            }
            i += 1
        }
    }
}
