//
//  BarcodeScanner.swift
//  Soulmesh
//
//  Created by Tyler Wright on 11/29/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeScanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    
    
    @IBOutlet weak var lblDataType: UILabel!    //upper label where scanned info is displayed
    @IBOutlet weak var camView: UIView! //camera window
    @IBOutlet weak var dataInfo: UILabel!
    
    
    //Properties
    let captureSession = AVCaptureSession()
    var captureDevice:AVCaptureDevice?
    var captureLayer:AVCaptureVideoPreviewLayer?
    var scanString: String!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate    //get appDelegate
    
    
    
    //View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.setupCaptureSession()
    }
    
    //Session Startup
    private func setupCaptureSession()
    {
        self.captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let setupError:NSError?
        do {
            if let deviceInput = try AVCaptureDeviceInput(device: captureDevice) as? AVCaptureDeviceInput {
                //Add the input feed to the session and start it
                self.captureSession.addInput(deviceInput)
                self.setupPreviewLayer({
                    self.captureSession.startRunning()
                    self.addMetaDataCaptureOutToSession()
                })  }
        } catch {
            self.showError("error")
        }
        
    }
    
    private func setupPreviewLayer(completion:() -> ())
    {
        self.captureLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let capLayer = self.captureLayer
        {
            capLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            capLayer.frame = self.camView.frame
            self.view.layer.addSublayer(capLayer)
            completion()
        }
        else
        {
            self.showError("An error occured beginning video capture.")
        }
    }
    
    //Metadata capture
    private func addMetaDataCaptureOutToSession()
    {
        let metadata = AVCaptureMetadataOutput()
        self.captureSession.addOutput(metadata)
        metadata.metadataObjectTypes = metadata.availableMetadataObjectTypes
        metadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    }
    
    //Delegate Methods
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        for metaData in metadataObjects
        {
            let decodedData:AVMetadataMachineReadableCodeObject = metaData as! AVMetadataMachineReadableCodeObject
            self.scanString = decodedData.stringValue
            self.lblDataType.text = self.scanString //display barcode info
            appDelegate.barcodeIn = self.scanString //set appDelegate variable to barcode info 
            
        }
    }
    
    //Utility Functions
    private func showError(error:String)
    {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .Alert)
        let dismiss:UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler:{(alert:UIAlertAction) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(dismiss)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func acceptScan(sender: AnyObject) {
        
    }
}