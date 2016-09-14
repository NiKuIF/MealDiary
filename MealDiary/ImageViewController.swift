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
    
    @IBAction func cancelAddItem(_ sender: UIBarButtonItem) {
        NewItemContent.clear()
        self.dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.isUserInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(ImageViewController.takePhotoTapped(_:)))
        image.addGestureRecognizer(imageTapGesture)
        // Do any additional setup after loading the view.
    }
    func takePhotoTapped(_ sender: UITapGestureRecognizer) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        
        
        let alert = UIAlertController(title: "Take image", message: "Choose preferred one", preferredStyle: .alert)
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
                self.imagePicker.sourceType = .camera
                print("camera pressed")
                self.imagePicker.allowsEditing = false
                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.imagePicker.sourceType)!
                self.present(self.imagePicker, animated: true, completion: nil)
            }))
        }
      
        alert.addAction(UIAlertAction(title: "Library", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
                self.imagePicker.sourceType = .photoLibrary
                print ("library pressed")
                self.imagePicker.allowsEditing = false
                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.imagePicker.sourceType)!
                self.present(self.imagePicker, animated: true, completion: nil)
            }))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
      
    }
    

}

extension ImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        print("user cancled the camera/ photo library")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //let mediatype = info[UIImagePickerControllerMediaType] as! String
        
      
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        NewItemContent.image = self.imageView.image
        
        self.dismiss(animated: true, completion: nil)
    }
}
