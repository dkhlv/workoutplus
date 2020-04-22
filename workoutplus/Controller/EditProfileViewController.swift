//
//  EditProfileViewController.swift
//  workoutplus
//
//  Created by Diana Koval on 2020-04-21.
//  Copyright © 2020 Diana Koval. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height/2
        avatarImage.image = loadImage()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        cameraButton.imageView?.contentMode = .scaleAspectFit
        self.view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        if let imageData = avatarImage.image?.pngData() {
            CoreDataHelper.instance.saveImage(data: imageData)
        }
        
        
        if let userName = nameTextField.text {
            if userName != "" {
                CoreDataHelper.instance.saveUserInfo(data: userName)
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatarImage.contentMode = .scaleAspectFit
            avatarImage.image = userPickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    func loadImage() -> UIImage {
        let arr = CoreDataHelper.instance.fetchImage()
        let defaultImage = UIImage(named: "profile_icon")!
        
        if arr.capacity == 0 {
            return defaultImage
        } else {
            return UIImage(data: arr[0].img!)!
        }
    }
    
}
