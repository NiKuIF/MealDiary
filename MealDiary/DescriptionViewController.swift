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
        if(segue.identifier == "add_description")
        {
          NewItemContent.description = description_textview.text
        }
    }
    

}
