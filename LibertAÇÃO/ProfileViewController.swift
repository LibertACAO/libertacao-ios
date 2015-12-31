//
//  ProfileViewController.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/30/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var tabItem: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("DELETEME: 1")
        if let curUser = PFUser.currentUser() {
            print("DELETEME: 2")
            print(curUser)
        } else {
            print("DELETEME: 3")
            self.performSegueWithIdentifier("goToLogin", sender: self)
        }

        // Do any additional setup after loading the view.
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
