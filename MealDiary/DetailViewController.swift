//
//  DetailViewController.swift
//  MealDiary
//
//  Created by admin on 30/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    var name_text: String?
    var image_name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in viewDidLoad : name : \(name_text) imagename: \(image_name)\n")
        name.text = name_text
        image.image = UIImage(named: image_name!)
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
