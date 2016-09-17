//
//  TabBarViewController.swift
//  MyQuotes
//
//  Created by Xavi on 26/08/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var recentViewController: UIViewController!
    var topsViewController: UIViewController!
    var favoritesViewController: UIViewController!
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        recentViewController = storyboard.instantiateViewController(withIdentifier: "recentViewController")
        
        topsViewController = storyboard.instantiateViewController(withIdentifier: "topsViewController")
        
        favoritesViewController = storyboard.instantiateViewController(withIdentifier: "favoritesViewController")
        
        viewControllers = [recentViewController, topsViewController, favoritesViewController]
        
        buttons[selectedIndex].isSelected = true
        tabPressed(buttons[selectedIndex])


        // Do any additional setup after loading the view.
    }
    
    @IBAction func tabPressed(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
