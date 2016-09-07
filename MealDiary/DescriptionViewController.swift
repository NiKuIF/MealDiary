//
//  DescriptionViewController.swift
//  MealDiary
//
//  Created by admin on 01/09/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit
import CoreData

class DescriptionViewController: UIViewController {

    @IBOutlet weak var description_textview: UITextView!
    
    @IBAction func save_item(sender: UIBarButtonItem) {
        NewItemContent.description = description_textview.text
        
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
        if(description_textview.text == "" || description_textview.text.isEmpty)
        {
            let alert = UIAlertController(title: "Info", message: "Add a description!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in }))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        

        NSNotificationCenter.defaultCenter().postNotificationName("appendItem", object: nil)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        description_textview.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20)
        description_textview.text = NewItemContent.description
        

        // Do any additional setup after loading the view.
    }
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            NewItemContent.description = description_textview.text
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
