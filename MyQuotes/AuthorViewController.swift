//
//  AuthorViewController.swift
//  MyQuotes
//
//  Created by Xavi on 19/09/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var authorsTableView: UITableView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var authorsArray: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorsTableView.rowHeight = UITableViewAutomaticDimension
        authorsTableView.estimatedRowHeight = 95
        authorsTableView.separatorStyle = .none
        NetworkController.getAuthors(){
            result in
            print(result)
            self.authorsArray = result
            self.authorsTableView.reloadData()
        }
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = backgroundImageView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
//        backgroundImageView.addSubview(blurEffectView)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.authorsArray != nil){
            return (self.authorsArray?.count)!
        }
        return 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell") as? AuthorTableViewCell{
            if let author = authorsArray?[indexPath.row] as? Author {
                cell.setAuthorName(name: author.name!)
                cell.setAuthorPhoto(fromUrl: author.photo!)
                cell.setQuotesNumber(numQuotes: author.quotesCount!)
                return cell
            }
        }
        return UITableViewCell()
    }

}
