//
//  AuthorViewController.swift
//  MyQuotes
//
//  Created by Xavi on 19/09/16.
//  Copyright © 2016 xavi. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell") as? AuthorTableViewCell{
            
            return cell
        }
        
        return UITableViewCell()
    }

}
