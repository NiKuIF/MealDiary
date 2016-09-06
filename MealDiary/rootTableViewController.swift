//
//  rootTableViewController.swift
//  MealDiary
//
//  Created by admin on 30/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit
import CoreData

class rootTableViewController: UITableViewController{
    
    var meals = [NSManagedObject]()
    var Image : String = String("stefan.jpg")
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.appendMeals(_:)),name:"appendItem", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateMeal(_:)), name: "updateItem", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Meals")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            meals = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func appendMeals(notification: NSNotification)
    {
        print("save item")
        let title = NewItemContent.title
        let description = NewItemContent.description
        let image = NewItemContent.image
        let imageData = NSData(data: UIImageJPEGRepresentation(image!, 1.0)!)
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Meals",
                                                        inManagedObjectContext:managedContext)
        
        let meal = NSManagedObject(entity: entity!,
                                   insertIntoManagedObjectContext: managedContext)
        
        //3
        meal.setValue(title, forKey: "meal_title")
        meal.setValue(description, forKey: "meal_description")
        meal.setValue(imageData, forKey: "meal_image")
        
        //4
        do {
            try managedContext.save()
            //5
            meals.append(meal)
            NewItemContent.clear()
            tableview.reloadData()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }

    func updateMeal(notification: NSNotification)
    {
        let object = notification.object as! NSDictionary
        let meal = meals[object.valueForKey("index") as! Int]
        let imageData = NSData(data: UIImageJPEGRepresentation(NewItemContent.image!, 1.0)!)
        
        meal.setValue(NewItemContent.title, forKey: "meal_title")
        meal.setValue(NewItemContent.description, forKey: "meal_description")
        meal.setValue(imageData, forKey: "meal_image")
        
        do {
            try meal.managedObjectContext?.save()
            NewItemContent.clear()
            tableview.reloadData()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let meal = meals[indexPath.row]
        cell.textLabel?.text = meal.valueForKey("meal_title") as? String
        cell.imageView?.image = UIImage(data: (meal.valueForKey("meal_image") as? NSData)!);
        
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(meals[indexPath.row] )
            meals.removeAtIndex(indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "cell_click")
        {
            let indexPath = tableview.indexPathForCell(sender as! UITableViewCell)
            //print("prepare segue \(indexPath?.row)\n")
            
            let dest_vc : DetailViewController = segue.destinationViewController as! DetailViewController
            let meal = meals[(indexPath?.row)!]
            
            dest_vc.index = (indexPath?.row)! as Int
            dest_vc.title_text = meal.valueForKey("meal_title") as? String
            dest_vc.description_text = meal.valueForKey("meal_description") as? String
            dest_vc.image = UIImage(data: (meal.valueForKey("meal_image") as? NSData)!)
        }
        
    }
    
    

}
