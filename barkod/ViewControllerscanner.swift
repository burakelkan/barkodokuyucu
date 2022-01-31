//
//  ViewControllerscanner.swift
//  barkod
//
//  Created by halil ibrahim Elkan on 22.12.2021.
//

import AVFoundation
import UIKit

class ViewControllerscanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    
    var view1 = ViewController()
    required init?(coder aDecoder: NSCoder){
        
        
        
      
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "QR Code", image: UIImage(named: "barkod"), tag: 2)
        
       
        
        
        
        
    }
    
    
    class CameraView: UIView {
        override class var layerClass: AnyClass {
            get {
                return AVCaptureVideoPreviewLayer.self
            }
        }
        
        override var layer: AVCaptureVideoPreviewLayer {
            get {
                return super.layer as! AVCaptureVideoPreviewLayer
            }
        }
    }
    var cameraView: CameraView!
    override func loadView() {
        cameraView = CameraView()
        
        view = cameraView
    }
    let session = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: AVCaptureSession.self.description(), attributes: [], target: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Kurulum
        session.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(for: .video)
                                
        if (videoDevice != nil) {
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!)
            
            if (videoDeviceInput != nil) {
                if (session.canAddInput(videoDeviceInput!)) {
                    session.addInput(videoDeviceInput!)
                }
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (session.canAddOutput(metadataOutput)) {
                session.addOutput(metadataOutput)
                
                metadataOutput.metadataObjectTypes = [
                    .ean13,
                    .qr,
                    .dataMatrix         // ilaç barkod tipi
                ]
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            }
        }
        
        session.commitConfiguration()
        
        cameraView.layer.session = session
        cameraView.layer.videoGravity = .resizeAspectFill
        let videoOrientation: AVCaptureVideoOrientation
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            videoOrientation = .portrait
            
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
            
        case .landscapeLeft:
            videoOrientation = .landscapeLeft
            
        case .landscapeRight:
            videoOrientation = .landscapeRight
            
        default:
            videoOrientation = .portrait
        }
        
        cameraView.layer.connection?.videoOrientation = videoOrientation
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            self.session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sessionQueue.async {
            self.session.stopRunning()
            
            
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Kamera yönünü belirleme.()
        let videoOrientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            videoOrientation = .portrait
            
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
            
        case .landscapeLeft:
            videoOrientation = .landscapeRight
            
        case .landscapeRight:
            videoOrientation = .landscapeLeft
            
        default:
            videoOrientation = .portrait
        }
        
        cameraView.layer.connection?.videoOrientation = videoOrientation
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if (metadataObjects.count > 0 && metadataObjects.first is AVMetadataMachineReadableCodeObject) {
            let scan = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
         
            
            
           
            let alertController = UIAlertController(title: "Barkod Numarası", message: scan.stringValue, preferredStyle: .alert)
     
            
            
            let tamamTikla = UIAlertAction(title: "Yazdır", style: .cancel){
                action in
                print("tamam Tiklandi")
                
                
                
                
                let mesaj = scan.stringValue
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "sonuc") as! ViewController
                
                vc.mesaj = mesaj!
                
                self.present(vc, animated: true, completion: nil)
                
                
                
        }
            alertController.addAction(tamamTikla)
            self.present(alertController, animated: true)
        }
            
         
            
//            present(alertController, animated: true, completion: nil)
            
            
            
           
        }
    }



