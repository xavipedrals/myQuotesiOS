//
//  AuthorViewController.swift
//  MyQuotes
//
//  Created by Xavi on 19/09/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

//    @IBOutlet weak var authorsTableView: UITableView!
    
    @IBOutlet weak var authorsCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var authorsArray: NSMutableArray?
    var cellWidth: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        authorsTableView.rowHeight = UITableViewAutomaticDimension
//        authorsTableView.estimatedRowHeight = 95
//        authorsTableView.separatorStyle = .none
        let screenSize: CGRect = UIScreen.main.bounds
        self.cellWidth = (Int(screenSize.width) / 2) - 5;
        NetworkController.getAuthors(){
            result in
            print(result)
            self.authorsArray = result
//            self.authorsTableView.reloadData()
            self.authorsCollectionView.reloadData()
        }
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        backgroundImageView.addSubview(blurEffectView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.authorsArray != nil){
                        return (self.authorsArray?.count)!
                    }
                    return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "authorCollectionCell", for: indexPath) as? AuthorCollectionViewCell {
            if let author = authorsArray?[indexPath.row] as? Author {
                cell.initCell(from: author)
                return cell
            }
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth!, height: cellWidth!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        if (self.authorsArray != nil){
//            return (self.authorsArray?.count)!
//        }
//        return 0
//
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell") as? AuthorTableViewCell{
//            if let author = authorsArray?[indexPath.row] as? Author {
//                cell.setAuthorName(name: author.name!)
//                cell.setAuthorPhoto(fromUrl: author.photo!)
//                cell.setQuotesNumber(numQuotes: author.quotesCount!)
//                return cell
//            }
//        }
//        return UITableViewCell()
//    }

}
