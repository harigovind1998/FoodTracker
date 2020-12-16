//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Hari Govind on 2019-08-15.
//  Copyright © 2019 Hari Govind. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveMealButton: UIBarButtonItem!
    
    
    /*
     This is passed by 'MealViewController' in the prepare(for:sender) function
     */
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Sets the delegate of the nameTextField object as the istance of ViewController
        nameTextField.delegate = self
        
        if let meal = meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.image
            ratingControl.rating = meal.rating
        }
        
        
        updateSaveButton()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
        navigationItem.title = nameTextField.text
    }
    
    // Disable save button while editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveMealButton.isEnabled = false
    }
    
    // MARK: UIIMagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss picker if user cancels
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Access the original image
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //Set the photoImageView image to the selected image
        photoImageView.image = selectedImage
        
        //Dismiss UIImagePicker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveMealButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Create a meal object
        meal = Meal(name: name, image: photo, rating: rating)


    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide keyboard if present
        nameTextField.resignFirstResponder()
        
        // View controller that allows users to pick images from photo library
        let imagePickerController = UIImagePickerController()
        
        // Restricting images to images present in photo library
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode{
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else{
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    //MARK: Private Methods
    private func updateSaveButton(){
        let text = nameTextField.text ?? "";
        saveMealButton.isEnabled = !text.isEmpty
        
    }
}

