//
//  ViewController.swift
//  MealDiary
//
//  Created by admin on 19/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

   
    
    @IBOutlet weak var tableView: UITableView!
    var names = ["stefan", "julia"]
    var images = [UIImage(named: "stefan"), UIImage(named: "julia")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        cell.name.text = names[indexPath.row]
        cell.photo.image = images[indexPath.row]
     
        return cell
        
    }


}

