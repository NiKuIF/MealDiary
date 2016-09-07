//
//  TitleViewController.swift
//  MealDiary
//
//  Created by admin on 01/09/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    @IBOutlet weak var title_textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title_textfield.text = NewItemContent.title
        title_textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(textField: UITextField) {
        NewItemContent.title = title_textfield.text
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "add_title")
        {
            let title = title_textfield.text
            NewItemContent.title = title
            
        }
    }
 
    

}
