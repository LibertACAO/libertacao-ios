//
//  LoginViewController.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/31/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DELETEME: OI")

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
    @IBAction func login(sender: UIButton) {
        SVProgressHUD.show()
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user, error) -> Void in
            if error == nil {
                print("DELETEME: Logged in")
            } else {
                print(error)
                Alert.show(self, title: "TODO", message: "TODO: Specifiy error type")
                
            }
        }
        
    }

}
