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
        
        self.titleLabel.isUserInteractionEnabled = true
        let titleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.editTitleTapped(_:)))
        titleLabel.addGestureRecognizer(titleTapGesture)
        
        self.mealImageView.isUserInteractionEnabled = true
        let imageLongTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.takePhotoTapped(_:)))
        mealImageView.addGestureRecognizer(imageLongTapGesture)
        
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewPhotoTapped(_:)))
        mealImageView.addGestureRecognizer(imageTapGesture)

        self.ratingLabel.isUserInteractionEnabled = true
        let ratingTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.editRatingTapped(_:)))
        ratingLabel.addGestureRecognizer(ratingTapGesture)
        // Do any additional setup after loading the view.
    }

    @IBAction func share_detail_item(_ sender: UIBarButtonItem)
    {
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // set up activity view controller
        let objectsToShare: [AnyObject] = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func takePhotoTapped(_ sender: UILongPressGestureRecognizer) {
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

    func viewPhotoTapped(_ sender: UITapGestureRecognizer)
    {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let imageView = sender.view as! UIImageView
        newImageView = UIImageView(image: imageView.image)
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = UIColor.black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage(_:)))
        
        let scrollView = UIScrollView(frame: self.view.frame)
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 6.0
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = UIColor.black
        scrollView.addSubview(newImageView)
        scrollView.delegate = self
        
      
        scrollView.addGestureRecognizer(tap)
        self.view.addSubview(scrollView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.newImageView
    }

    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func editRatingTapped(_ sender: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: " Edit rating", message: "Enter new number from 1 to 10", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in self.changeActiveRating(alert.textFields![0].text!)}))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter new number from 1 to 10:"
            textField.text = "\(self.rating!)"
            textField.keyboardType = .decimalPad
            textField.clearButtonMode = .whileEditing
            
        })
        
        self.present(alert, animated: true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editTitleTapped(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: " Edit title", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in self.changeActiveTitleText(alert.textFields![0].text!)}))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter new title:"
            textField.text = self.titleLabel.text
            textField.clearButtonMode = .whileEditing
            
        })
        
        self.present(alert, animated: true, completion:nil)
    }
    
    func changeActiveRating(_ new_rating: String)
    {
        var tmp_rating: String = new_rating
        print("change rating to \(tmp_rating)")
        if(tmp_rating == "")
        {
            tmp_rating = "\(self.rating!)"
        }
        
        rating = Int(tmp_rating)! < 1 || Int(tmp_rating)! > 10 ? self.rating! : Int(tmp_rating)!
        ratingLabel.text = "Rating: \(rating!)"
        something_changed = true
    }
    
    func changeActiveTitleText(_ new_title: String)
    {
        print("change title to : \(new_title)")
        titleLabel.text = new_title
        something_changed = true
    }
    
 
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil {
            if(something_changed || descriptionTextView.text != description_text)
            {
                print("update item")
                NewItemContent.title = titleLabel.text
                NewItemContent.description = descriptionTextView.text
                NewItemContent.image = mealImageView.image
                NewItemContent.rating = rating!
                let object:NSDictionary = ["index": index!]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "updateItem"), object: object)
            }

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        print("user cnacled the camera/ photo library")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //let mediatype = info[UIImagePickerControllerMediaType] as! String
        
        
        self.mealImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        something_changed = true
        
        self.dismiss(animated: true, completion: nil)
    }
}
