//
//  ViewController.swift
//  Incognito
//
//  Created by Corinne Krych on 28/02/15.
//  Copyright (c) 2015 raywenderlich. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary

// TODO add import

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hatImage: UIImageView!
    @IBOutlet weak var glassesImage: UIImageView!
    @IBOutlet weak var moustacheImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO add http instance
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Gesture Action
    
    @IBAction func move(_ recognizer: UIPanGestureRecognizer) {
        //return
        let translation = recognizer.translation(in: self.view)
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x,
            y:recognizer.view!.center.y + translation.y)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func pinch(_ recognizer: UIPinchGestureRecognizer) {
        recognizer.view!.transform = recognizer.view!.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }
    
    @IBAction func rotate(_ recognizer: UIRotationGestureRecognizer) {
        recognizer.view!.transform = recognizer.view!.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0

    }
    
    // MARK: - Menu Action
    
    @IBAction func openCamera(_ sender: AnyObject) {
        openPhoto()
    }
    
    @IBAction func hideShowHat(_ sender: AnyObject) {
        hatImage.isHidden = !hatImage.isHidden
    }
    
    @IBAction func hideShowGlasses(_ sender: AnyObject) {
        glassesImage.isHidden = !glassesImage.isHidden
    }
    
    @IBAction func hideShowMoustache(_ sender: AnyObject) {
        moustacheImage.isHidden = !moustacheImage.isHidden
    }
    
    @IBAction func share(_ sender: AnyObject) {
        // TODO: your turn to code it!
    }

    // MARK: - UIImagePickerControllerDelegate
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [AnyHashable: Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_: UIGestureRecognizer,
        _ shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }
    
    // MARK: - Private functions
    
    fileprivate func openPhoto() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func presentAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func snapshot() -> Data {
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let fullScreenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(fullScreenshot!, nil, nil, nil)
     return UIImageJPEGRepresentation(fullScreenshot!, 0.5)!
    }

}

