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
    
    var title_text: String?
    var description_text: String?
    var image_name_text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = title_text
        descriptionTextView.text = description_text
        mealImageView.image = UIImage(named: image_name_text!)
        // Do any additional setup after loading the view.
    }					

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editTitle(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Edit title", message: "Enter new title", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in self.changeActiveTitleText(alert.textFields![0].text!)}))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter text:"
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
    }
    
    func alertControllerBackgroundTapped()
    {
        print("background tap")
        self.dismissViewControllerAnimated(true, completion: nil)
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
