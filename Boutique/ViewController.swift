//
//  ViewController.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imgCamera: UIImageView!
    var imgName = ""
    var isImageCaptured = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTakeSelfie(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized{
                self.openCameraAfterAccessGrantedByUser()
            } else{
                DispatchQueue.main.async { [unowned self] in
                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted :Bool) -> Void in
                        if granted == true {
                            // User granted
                            self.openCameraAfterAccessGrantedByUser()
                        }
                        else{
                            // User Rejected
                            self.alertToEncourageCameraAccessWhenApplicationStarts()
                        }
                    });
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        actionSheet.popoverPresentationController?.permittedArrowDirections = .up
        actionSheet.popoverPresentationController?.sourceView = sender as UIView
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x:sender.bounds.midX, y:sender.bounds.midY+20 , width:0.0, height: 0.0)
        actionSheet.popoverPresentationController?.backgroundColor = UIColor.white
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imgCamera.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgCamera.cornerRadius = 60.0
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            imgName = Date().toString(dateFormat: "ddMMYYYY_HHmm") + "image.png"
            let fileURL = documentDirectory.appendingPathComponent(imgName)
            let image = imgCamera.image
            if let imageData = UIImageJPEGRepresentation(image!, 0.5) {
                try imageData.write(to: fileURL)
            }
        } catch {
            print(error)
        }
        isImageCaptured = true
        self.dismiss(animated: false, completion: nil)
    }
    
    func openCameraAfterAccessGrantedByUser()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = UIImagePickerControllerSourceType.camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //Show Camera Unavailable Alert
    
    func alertToEncourageCameraAccessWhenApplicationStarts()
    {
        let cameraUnavailableAlertController = UIAlertController (title: Constants.app_name.rawValue, message: "True Value wants to access phone camera", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .destructive) { (_) -> Void in
            let settingsUrl = URL(string:UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                DispatchQueue.main.async {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        cameraUnavailableAlertController .addAction(settingsAction)
        cameraUnavailableAlertController .addAction(cancelAction)
        self.present(cameraUnavailableAlertController , animated: true, completion: nil)
    }
    
    func photoLibrary() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }

    @IBAction func btnRegistration(_ sender: Any) {
        DispatchQueue.main.async {
            let viewVC = ControllerFetcher().registrationVC
            if self.isImageCaptured == true{
                viewVC.userImage = self.imgCamera.image!
                viewVC.userImageName = self.imgName
            }
            self.navigationController?.pushViewController(viewVC, animated: true)
        }
    }
}

