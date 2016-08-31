//
//  TitleViewController.swift
//  MealDiary
//
//  Created by admin on 31/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    var imagePicker: UIImagePickerController!
    
    @IBAction func cancelAddItem(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("back_to_menu", sender: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.userInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(TitleViewController.takePhotoTapped(_:)))
        image.addGestureRecognizer(imageTapGesture)
        // Do any additional setup after loading the view.
    }
    func takePhotoTapped(sender: UITapGestureRecognizer) {
        print("take photo")
        takePhoto()
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
        image.image = UIImage(named: "stefan.jpg")
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
