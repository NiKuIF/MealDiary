//
//  RatingViewController.swift
//  MealDiary
//
//  Created by admin on 12/09/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit


class RatingViewController: UIViewController {

    @IBOutlet weak var ratingControl: UISegmentedControl!
    
    @IBAction func saveItem(sender: UIBarButtonItem) {
        sender.enabled = false
        NewItemContent.rating = ratingControl.selectedSegmentIndex + 1
        
        if(NewItemContent.image == nil)
        {
            let alert = UIAlertController(title: "Info", message: "Add an image!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in }))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if(NewItemContent.title == "" || NewItemContent.title == nil)
        {
            let alert = UIAlertController(title: "Info", message: "Add a title!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in }))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if(NewItemContent.description == "" || NewItemContent.description == nil)
        {
            let alert = UIAlertController(title: "Info", message: "Add a description!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in }))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        //if rating is not set -> alert and sender enabled is trues
        if NewItemContent.rating == 0
        {
            let alert = UIAlertController(title: "Info", message: "Add a rating!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in }))
            self.presentViewController(alert, animated: true, completion: nil)
            sender.enabled = true
            return
        }
        
        print("send append item notification")
        NSNotificationCenter.defaultCenter().postNotificationName("appendItem", object: nil)
        print("going to dismiss add item view")
        self.dismissViewControllerAnimated(false, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingControl.selectedSegmentIndex = NewItemContent.rating - 1
        
        // Do any additional setup after loading the view.
    }
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
           NewItemContent.rating = ratingControl.selectedSegmentIndex + 1
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}
