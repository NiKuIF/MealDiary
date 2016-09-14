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
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        NewItemContent.rating = ratingControl.selectedSegmentIndex + 1
        
        if(NewItemContent.image == nil)
        {
            let alert = UIAlertController(title: "Info", message: "Add an image!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if(NewItemContent.title == "" || NewItemContent.title == nil)
        {
            let alert = UIAlertController(title: "Info", message: "Add a title!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if(NewItemContent.description == "" || NewItemContent.description == nil)
        {
            let alert = UIAlertController(title: "Info", message: "Add a description!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        //if rating is not set -> alert and sender enabled is trues
        if NewItemContent.rating == 0
        {
            let alert = UIAlertController(title: "Info", message: "Add a rating!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in }))
            self.present(alert, animated: true, completion: nil)
            sender.isEnabled = true
            return
        }
        
        print("send append item notification")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "appendItem"), object: nil)
        print("going to dismiss add item view")
        self.dismiss(animated: false, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingControl.selectedSegmentIndex = NewItemContent.rating - 1
        
        // Do any additional setup after loading the view.
    }
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}
