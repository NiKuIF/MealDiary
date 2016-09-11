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
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    @IBAction func cancelAddItem(sender: UIBarButtonItem) {
        NewItemContent.clear()
        self.dismissViewControllerAnimated(true, completion: nil)
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
        
        
        
        
        let alert = UIAlertController(title: "Take image", message: "Choose preferred one", preferredStyle: .Alert)
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                self.imagePicker.sourceType = .Camera
                print("camera pressed")
                self.imagePicker.allowsEditing = false
                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(self.imagePicker.sourceType)!
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }))
        }
      
        alert.addAction(UIAlertAction(title: "Library", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
                self.imagePicker.sourceType = .PhotoLibrary
                print ("library pressed")
                self.imagePicker.allowsEditing = false
                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(self.imagePicker.sourceType)!
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }))
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
   
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
      
    }
    

}

extension ImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("user cnacled the camera/ photo library")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //let mediatype = info[UIImagePickerControllerMediaType] as! String
        
      
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        NewItemContent.image = self.imageView.image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}