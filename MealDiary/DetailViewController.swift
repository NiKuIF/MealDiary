//
//  DetailViewController.swift
//  MealDiary
//
//  Created by admin on 30/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mealImageView: UIImageView!
    
    var index : Int?
    var title_text: String?
    var description_text: String?
    var image: UIImage?
    
    var something_changed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = title_text
        descriptionTextView.text = description_text
        mealImageView.image = image
        
        self.titleLabel.userInteractionEnabled = true
        let titleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.editTitleTapped(_:)))
        titleLabel.addGestureRecognizer(titleTapGesture)

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editTitleTapped(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: " Edit title", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in self.changeActiveTitleText(alert.textFields![0].text!)}))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter new title:"
            textField.text = self.titleLabel.text
            textField.clearButtonMode = .WhileEditing
            
        })
        
        self.presentViewController(alert, animated: true, completion:{
            alert.view.superview?.userInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    
    func changeActiveTitleText(new_title: String)
    {
        print("change title to : \(new_title)")
        titleLabel.text = new_title
        something_changed = true
    }
    
    func alertControllerBackgroundTapped()
    {
        print("background tap")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            if(something_changed || descriptionTextView.text != description_text)
            {
                print("update item")
                let object:NSDictionary = ["index": index!, "title": titleLabel.text!, "description": descriptionTextView.text]
                NSNotificationCenter.defaultCenter().postNotificationName("updateItem", object: object)
            }
            
        }
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
