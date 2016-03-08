//
//  ViewController.swift
//  PointOfSale
//
//  Created by 왕승현 on 2016. 1. 27..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit
import AVFoundation
import RSBarcodes_Swift

class AddProductView: UIViewController {
    
    var didAddHandler: (Product-> Void)?
        @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var barcodeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        let devices = AVCaptureDevice.devices()
        
        
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil{
                    }
                }
            }
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func capture(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        //addProduct()
        let product = Product(
            name: productNameTextField.text!,
            barcode: barcodeTextField.text!,
            price: Int(priceTextField.text!)!
        )
        self.didAddHandler?(product)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func barcodeScan(sender: AnyObject) {
        let scanView = RSCodeReaderViewController()
        let backButton = UIButton()
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let buttonFrame = CGRect(x: screenWidth - screenWidth / 4,
                                y: UIScreen.mainScreen().bounds.size.height - 50,
                                width: screenWidth / 4 ,
                                height: 50)
        backButton.frame = buttonFrame
        backButton.backgroundColor = UIColor.whiteColor()
        backButton.setTitle("취소", forState: UIControlState.Normal )
        backButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back:", forControlEvents: .TouchUpInside)

        
        backButton.addTarget(scanView, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)

        
        scanView.view.addSubview(backButton)
        var code = ""
        scanView.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
        scanView.cornersLayer.strokeColor = UIColor.yellowColor().CGColor
        
        scanView.barcodesHandler = { barcodes in
            for barcode in barcodes {
                if let codes = barcode.stringValue{
                    dispatch_async(dispatch_get_main_queue(), {
                        self.barcodeTextField.text! = codes
                        scanView.session.stopRunning()
                        scanView.dismissViewControllerAnimated(true, completion: nil)
                    })
                }
            }
        }
        self.presentViewController(scanView, animated: true, completion: nil)
        func back(){
            //scanView.session.stopRunning()
            //scanView.dismissViewControllerAnimated(true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

extension AddProductView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let takenImage: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        productImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        UIImageWriteToSavedPhotosAlbum(takenImage, nil, nil, nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
}