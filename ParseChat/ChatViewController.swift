//
//  ChatViewController.swift
//  ParseChat
//
//  Created by ZengJintao on 2/11/16.
//  Copyright © 2016 ZengJintao. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var messageTableView: UITableView!
    
    var messages:[PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chat"
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 300
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! MessageTableViewCell
        cell.messageLabel.text = messages![indexPath.row]["text"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cnt = messages?.count {
            return cnt
        } else {
            return 0
        }
    }
    
    @IBAction func sendPressed(sender: AnyObject) {
        var message = PFObject(className:"Message")
        message["text"] = messageTextField.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("message sent")
            } else {
                // There was a problem, check error.description
            }
        }
        messageTextField.text = ""
        refreshMessage()
    }
    
    func onTimer() {
        // Add code to be run periodically
        refreshMessage()
    }
    
    func refreshMessage() {
        var query = PFQuery(className:"Message")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.messages = objects
                    for object in objects {
                        print(object.objectId)
                    }
                }
                self.messageTableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
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
