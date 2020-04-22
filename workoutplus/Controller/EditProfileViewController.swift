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
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        cameraButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
                
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        if let imageData = avatarImage.image?.pngData() {
            CoreDataHelper.instance.saveImage(data: imageData)
        }
        
        if let userName = nameTextField.text {
            CoreDataHelper.instance.saveUserInfo(data: userName)
        }
        
        performSegue(withIdentifier: "shareUserData", sender: nil)
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shareUserData" {
            if let destination = segue.destination as? ProgressViewController {
                destination.userAvatarImage = avatarImage
                destination.userNameLabel.text = userName ?? "User"
            }
        }
        
    }
    
}
