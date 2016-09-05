//
//  TitleViewController.swift
//  MealDiary
//
//  Created by admin on 31/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var imagePicker: UIImagePickerController!
    
    @IBAction func cancelAddItem(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("back_to_menu", sender: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.userInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(ImageViewController.takePhotoTapped(_:)))
        image.addGestureRecognizer(imageTapGesture)
        // Do any additional setup after loading the view.
    }
    func takePhotoTapped(sender: UITapGestureRecognizer) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            imagePicker.sourceType = .Camera
        }
        else
        {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(imagePicker.sourceType)!
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    
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

extension ImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("user cnacled the camera/ photo library")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //let mediatype = info[UIImagePickerControllerMediaType] as! String
        
      
        self.image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        NewItemContent.image = self.image.image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}