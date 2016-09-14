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
    var appDelegate: AppDelegate?
    var managedContext: NSManagedObjectContext?
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1
        appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        
        managedContext = appDelegate!.managedObjectContext
        
        let background = UIImageView(image: UIImage(named: "spies"))
    
        background.alpha = 1
        tableview.backgroundView = background
        tableview.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
        NotificationCenter.default.addObserver(self, selector: #selector(self.appendMeals(_:)),name:NSNotification.Name(rawValue: "appendItem"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMeal(_:)), name: NSNotification.Name(rawValue: "updateItem"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Meals")
 
        
        //3
        do {
            let results =
                try managedContext!.fetch(fetchRequest)
            meals = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func appendMeals(_ notification: Notification)
    {
        print("save item")
        let title = NewItemContent.title
        let description = NewItemContent.description
        let image = NewItemContent.image
        
        let rating = NSDecimalNumber(value: NewItemContent.rating as Int)
        NewItemContent.clear()
        let imageData = NSData(data: UIImageJPEGRepresentation(image!, 1.0)!) as Data
        
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "Meals",
                                                        in:managedContext!)
        
        let meal = NSManagedObject(entity: entity!,
                                   insertInto: managedContext)
        
        //3
        meal.setValue(title, forKey: "meal_title")
        meal.setValue(description, forKey: "meal_description")
        meal.setValue(imageData, forKey: "meal_image")
        meal.setValue(rating, forKey: "meal_rating")
        //4
        do {
            try managedContext!.save()
            //5
            meals.append(meal)
            //NewItemContent.clear()
            tableview.reloadData()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }

    func updateMeal(_ notification: Notification)
    {
        let object = notification.object as! NSDictionary
        let meal = meals[object.value(forKey: "index") as! Int]
        let imageData = NSData(data: UIImageJPEGRepresentation(NewItemContent.image!, 1.0)!) as Data
        let rating = NSDecimalNumber(value: NewItemContent.rating as Int)
        meal.setValue(NewItemContent.title, forKey: "meal_title")
        meal.setValue(NewItemContent.description, forKey: "meal_description")
        meal.setValue(imageData, forKey: "meal_image")
        meal.setValue(rating, forKey: "meal_rating")
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell

        let meal = meals[(indexPath as NSIndexPath).row]
    
        //cell.ImageView.image = UIImage(data: (meal.valueForKey("meal_image") as? NSData)!);
        cell.title.text = meal.value(forKey: "meal_title") as? String
        cell.rating.progress = ((meal.value(forKey: "meal_rating") as? NSDecimalNumber)?.floatValue)! / 10
        
        let background_selected = UIView()
        background_selected.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6)
        cell.selectedBackgroundView = background_selected
        /*let background = UIView()
        background.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)*/
        let backgroundView = UIImageView(image: UIImage(data: (meal.value(forKey: "meal_image") as? Data)!))
        backgroundView.contentMode = .scaleAspectFill
        cell.backgroundView = backgroundView//background
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.delete(meals[(indexPath as NSIndexPath).row] )
            meals.remove(at: (indexPath as NSIndexPath).row)
            do {
                try context.save()
            } catch _ {
            }
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRows(at: [indexPath], with: .fade)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "cell_click")
        {
            let indexPath = tableview.indexPath(for: sender as! UITableViewCell)
            //print("prepare segue \(indexPath?.row)\n")
            
            let dest_vc : DetailViewController = segue.destination as! DetailViewController
            let meal = meals[((indexPath as NSIndexPath?)?.row)!]
            
            dest_vc.index = ((indexPath as NSIndexPath?)?.row)! as Int
            dest_vc.title_text = meal.value(forKey: "meal_title") as? String
            dest_vc.description_text = meal.value(forKey: "meal_description") as? String
            dest_vc.image = UIImage(data: (meal.value(forKey: "meal_image") as? Data)!)
            dest_vc.rating = Int(((meal.value(forKey: "meal_rating") as? NSDecimalNumber)?.floatValue)!)
        }
        
    }
    
    

}
