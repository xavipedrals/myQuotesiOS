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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight = 300
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.heightAtIndexPath = NSMutableDictionary()
        NetworkController.getRecentQuotes(){
            result in
            self.quotesArray = result
            self.tableView.reloadData()
        }
        self.isDataRefreshing = false
        self.stopRefreshing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//        self.title = "Recent"
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: false)
        self.lastSelectedIndex = (indexPath as NSIndexPath).row
        self.performSegue(withIdentifier: "showRecentDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.heightAtIndexPath.object(forKey: indexPath)
        if ((height) != nil) {
            return CGFloat((height! as AnyObject).floatValue)
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let height = cell.frame.size.height
        self.heightAtIndexPath.setObject(height, forKey: indexPath as NSCopying)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.quotesArray != nil){
            return (self.quotesArray?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell") as? RecentTableViewCell{
            if let quoteObj = quotesArray![indexPath.row] as? Quote {

                cell.backgroundImage.layer.backgroundColor = hexStringToUIColor(quoteObj.backgroundColor!).cgColor
                cell.backgroundImage.kf_setImage(with: URL(string: quoteObj.backgroundImg!)!)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        //IPAD
        //return screenWidth * 0.55
        
        //IPHONE
        return screenHeight * 0.37
    }
    
    //when table bottom is reached get more rows
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
                        var indexPathsArray = [IndexPath]()
                        for index in 0...result.count-1 {
                            let newIndex = index + self.quotesArray!.count
                            indexPathsArray.append(IndexPath(row: newIndex, section: 0))
                        }
                        self.quotesArray?.addObjects(from: result as [AnyObject])
                        
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: indexPathsArray, with: .bottom)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRecentDetail"{
            if let detailViewController = segue.destination as? SingleQuoteViewController{
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
    
    func updateQuoteLikes(_ idQuote: String, likeCount: Int){
        var i = 0
        var found = false
        while (!found && i < (quotesArray?.count)!){
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
