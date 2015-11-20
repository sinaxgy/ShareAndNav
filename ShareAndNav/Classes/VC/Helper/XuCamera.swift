//
//  XuCamera.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/18.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

protocol XuCameraDelegate:NSObjectProtocol {
    func XuCameraDidPickImage(image: UIImage)
    func XuCameraDidCancel()
}

class XuCamera: NSObject ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var delegate:XuCameraDelegate?
    
    func takePhoto(viewCtrl:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            let picker:UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            //picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            viewCtrl.presentViewController(picker, animated: true, completion: nil)             //yes?
        }else{
            let alert = UIAlertController(title: "摄像头不可用", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
            viewCtrl.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func openPictureLibrary(viewCtrl:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            let picker:UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            //picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            viewCtrl.presentViewController(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "照片库不可用", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
            viewCtrl.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //UIImagePickerControllerDelegate拍摄完执行
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var image:UIImage = info[UIImagePickerControllerOriginalImage]! as! UIImage
        if picker.sourceType == UIImagePickerControllerSourceType.Camera {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        if image.imageOrientation != UIImageOrientation.Up {
            UIGraphicsBeginImageContext(image.size)
            image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.XuCameraDidPickImage(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.XuCameraDidCancel()
    }
    
}
