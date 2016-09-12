//
//  DetailViewController.swift
//  MealDiary
//
//  Created by admin on 30/08/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mealImageView: UIImageView!
    
    var newImageView: UIImageView!
    var imagePicker: UIImagePickerController!
    
    var index : Int?
    var title_text: String?
    var description_text: String?
    var image: UIImage?
    var rating: Int?
    
    var something_changed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20)
        titleLabel.text = title_text
        descriptionTextView.text = description_text
        mealImageView.image = image
        ratingLabel.text = "Rating: \(rating!)"
        print(ratingLabel.text)
        
        self.titleLabel.userInteractionEnabled = true
        let titleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.editTitleTapped(_:)))
        titleLabel.addGestureRecognizer(titleTapGesture)
        
        self.mealImageView.userInteractionEnabled = true
        let imageLongTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.takePhotoTapped(_:)))
        mealImageView.addGestureRecognizer(imageLongTapGesture)
        
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewPhotoTapped(_:)))
        mealImageView.addGestureRecognizer(imageTapGesture)

        self.ratingLabel.userInteractionEnabled = true
        let ratingTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.editRatingTapped(_:)))
        ratingLabel.addGestureRecognizer(ratingTapGesture)
        // Do any additional setup after loading the view.
    }

    func takePhotoTapped(sender: UILongPressGestureRecognizer) {
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

    func viewPhotoTapped(sender: UITapGestureRecognizer)
    {
        let imageView = sender.view as! UIImageView
        newImageView = UIImageView(image: imageView.image)
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage(_:)))
        let scrollView = UIScrollView(frame: self.view.frame)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.userInteractionEnabled = true
        scrollView.backgroundColor = .blackColor()
        scrollView.addSubview(newImageView)
        scrollView.delegate = self
      
        scrollView.addGestureRecognizer(tap)
        self.view.addSubview(scrollView)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.newImageView
    }

    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    func editRatingTapped(sender: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: " Edit rating", message: "Enter new number from 1 to 10", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in self.changeActiveRating(alert.textFields![0].text!)}))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter new number from 1 to 10:"
            textField.text = "\(self.rating!)"
            textField.keyboardType = .DecimalPad
            textField.clearButtonMode = .WhileEditing
            
        })
        
        self.presentViewController(alert, animated: true, completion:nil)
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
        
        self.presentViewController(alert, animated: true, completion:nil)
    }
    
    func changeActiveRating(new_rating: String)
    {
        var tmp_rating: String = new_rating
        print("change rating to \(tmp_rating)")
        if(tmp_rating == "")
        {
            tmp_rating = "\(self.rating!)"
        }
        
        rating = Int(tmp_rating)! < 1 || Int(tmp_rating)! > 10 ? 0 : Int(tmp_rating)!
        ratingLabel.text = "Rating: \(rating!)"
        something_changed = true
    }
    
    func changeActiveTitleText(new_title: String)
    {
        print("change title to : \(new_title)")
        titleLabel.text = new_title
        something_changed = true
    }
    
 
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            if(something_changed || descriptionTextView.text != description_text)
            {
                print("update item")
                NewItemContent.title = titleLabel.text
                NewItemContent.description = descriptionTextView.text
                NewItemContent.image = mealImageView.image
                NewItemContent.rating = rating!
                let object:NSDictionary = ["index": index!]
                NSNotificationCenter.defaultCenter().postNotificationName("updateItem", object: object)
            }

        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touch")
        view.endEditing(true)
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

extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("user cnacled the camera/ photo library")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //let mediatype = info[UIImagePickerControllerMediaType] as! String
        
        
        self.mealImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        something_changed = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
