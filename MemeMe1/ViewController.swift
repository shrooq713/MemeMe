//
//  ViewController.swift
//  MemeMe1
//
//  Created by Areej Ali on 07/09/1440 AH.
//  Copyright © 1440 Shrooq Saleh. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    var memes: [Meme]!{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }


    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottonTextField: UITextField!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTextField(tf: topTextField, text: "TOP")
        setupTextField(tf: bottonTextField, text: "BOTTOM")
         share.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
         camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    func setupTextField(tf: UITextField, text: String) {
        tf.defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0,
        ]
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
    }

    func chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
        
    }
    @IBAction func pickAnimageFromAlbum(_ sender: Any) {
        chooseImageFromCameraOrPhoto(source: .photoLibrary)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        share.isEnabled = true
        
    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        chooseImageFromCameraOrPhoto(source: .camera)
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottonTextField.isFirstResponder{
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottonTextField.isFirstResponder{
        view.frame.origin.y = 0
        }
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottonTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        //dismiss(animated: true, completion: nil)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
       navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        return memedImage
    }
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityController, animated: true, completion: nil)
    }
}
