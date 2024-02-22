//
//  FaceAuthenticationViewController.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 22/02/2024.
//

import UIKit
import Vision
import AVFoundation

class FaceAuthenticationViewController : UIViewController {
    
    //  MARK:  UIView IBOutlet Connections
    
    
    //  MARK:  Private Global Variable & Instance Declarations
    var videoCaptureSession = AVCaptureSession()
    var previewLayout:CALayer!
    
    
    //  MARK:  View Lifecycle Delegate Method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //  MARK:  Button Actions
    
    
}


//   MARK:  Extension for Comman Methods

extension FaceAuthenticationViewController : AVCaptureVideoDataOutputSampleBufferDelegate{
    func configureCamera() {
        guard let camera = AVCaptureDevice.default(for: .video) else {
                return
            }
            
            do {
                let cameraInput = try AVCaptureDeviceInput(device: camera)
                videoCaptureSession.addInput(cameraInput)
            } catch {
                print(error)
                return
            }
            
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            videoCaptureSession.addOutput(videoOutput)
            
            previewLayout = AVCaptureVideoPreviewLayer(session: videoCaptureSession)
            previewLayout.frame = view.frame
            view.layer.addSublayer(previewLayout)

            videoCaptureSession.startRunning()
    }
}
