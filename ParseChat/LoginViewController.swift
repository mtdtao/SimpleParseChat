//
//  ViewController.swift
//  ParseChat
//
//  Created by ZengJintao on 2/11/16.
//  Copyright © 2016 ZengJintao. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: JVFloatLabeledTextField!
    
    @IBOutlet weak var passwordTextField: JVFloatLabeledTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signupPressed(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
//        user.email = "email@example.com"
        // other fields can be set just like with PFObject
//        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
//                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                print("successful signup")
                // Hooray! Let them use the app now.
            }
        }
    
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                print("successful login")
                self.performSegueWithIdentifier("goToChat", sender: self)
                
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    

}

