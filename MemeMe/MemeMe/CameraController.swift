//
//  CameraController.swift
//  MemeMe
//
//  Created by Alireza on 8/26/21.
//

import UIKit
import AVFoundation

class CameraController : UIViewController {
    
    let captureSession = AVCaptureSession()
    
    var backFacingCamera : AVCaptureDevice?
    var currentDevice : AVCaptureDevice!
    
    var stillImageOutPut : AVCapturePhotoOutput!
    var stillImage : UIImage?
    
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func unwindToCameraView(segue: UIStoryboardSegue) {
    
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        
        let setPhoto = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
        setPhoto.isAutoStillImageStabilizationEnabled = true
        setPhoto.isHighResolutionPhotoEnabled = true
        setPhoto.flashMode = .auto
        
        stillImageOutPut.isHighResolutionCaptureEnabled = true
        stillImageOutPut.capturePhoto(with: setPhoto, delegate: self)
    }
    
    private func configure () {
        
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let deviceBackSession = AVCaptureDevice.DiscoverySession ( deviceTypes : [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        for device in deviceBackSession.devices {
            if device.position == .back {
                backFacingCamera = device
            } else  {
                backFacingCamera = device
            }
        }
        
        currentDevice = backFacingCamera
        
        guard let captureDeviceInput = try? AVCaptureDeviceInput (device: currentDevice) else {
            return
        }
        
        stillImageOutPut = AVCapturePhotoOutput()
        
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(stillImageOutPut)
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        
    }
    
}

extension CameraController : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            return
        }
        
        guard let imageDeta = photo.fileDataRepresentation() else {
            return
        }
        
        stillImage = UIImage (data:  imageDeta)
        performSegue(withIdentifier: "showPhoto", sender: self)
    }
}
