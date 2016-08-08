//
//  RecentViewController.swift
//  MyQuotes
//
//  Created by Xavi on 30/07/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var quotesArray: NSMutableArray?
    var lastSelectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.getRecentQuotes(){
            result in
            self.quotesArray = result
            self.tableView.reloadData()
        }
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.quotesArray != nil){
            return (self.quotesArray?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCellWithIdentifier("recentCell") as? RecentTableViewCell{
            if let quoteObj = quotesArray![indexPath.row] as? Quote {
                print("cell ---------------------")
                print(quoteObj.author!)
                print(quoteObj.quote!)
                print(quoteObj.quoteBackground!)

                cell.backgroundImage.kf_setImageWithURL(NSURL(string: quoteObj.quoteBackground!)!)
                cell.authorLabel.text = quoteObj.author!
                cell.quoteLabel.text = quoteObj.quote!
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let screenWidth = UIScreen.mainScreen().bounds.width
        //IPAD
        //return screenWidth * 0.55
        
        //IPHONE
        return screenWidth * 0.7
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRecentDetail"{
            if let detailViewController = segue.destinationViewController as? SingleQuoteViewController{
                if let quoteObj = quotesArray![lastSelectedIndex!] as? Quote{
                    detailViewController.quoteStr = quoteObj.quote!
                    detailViewController.authorStr = quoteObj.author!
                    detailViewController.backgroundImgStr = quoteObj.quoteBackground!
                    detailViewController.authorImgStr = quoteObj.authorBackground!
                }
            }
        }
    }
}
