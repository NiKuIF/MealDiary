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

    @IBAction func create_item_btn_click(sender: UIBarButtonItem) {
        let managedObjectContext =
            (UIApplication.sharedApplication().delegate
                as! AppDelegate).managedObjectContext
        
        let entityDescription =
            NSEntityDescription.entityForName("Meals",
                                              inManagedObjectContext: managedObjectContext)
        
        let meal = Meals(entity: entityDescription!,
                               insertIntoManagedObjectContext: managedObjectContext)
        
        meal.meal_title = "test"
        meal.meal_description = "asdfasdfasfasdfasdfasfasfddafasdf"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
