//
//  HomeViewController.swift
//  PR DRS
//
//  Created by Dusan on 5/2/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit
import IPDFCameraViewController
import CoreLocation
import JGProgressHUD
import AVFoundation

class HomeViewController: UIViewController {

    @IBOutlet weak var m_containView: IPDFCameraViewController!
    var m_captureImage: UIImage?
    @IBOutlet weak var m_captureBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let progressHUD = JGProgressHUD(style: .dark)

        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized {
            
            progressHUD.textLabel.text = "Starting the Camera"
            progressHUD.indicatorView = JGProgressHUDIndeterminateIndicatorView()
            progressHUD.show(in: self.view)
        }
        
        DispatchQueue.main.async {
            self.m_containView.stop()
            self.m_containView.start()
            if progressHUD.isVisible == true {
                progressHUD.dismiss()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.m_captureBtn.clipsToBounds = true
        self.m_captureBtn.layer.cornerRadius = (self.m_captureBtn.frame.height) / 2
        self.m_captureBtn.layer.borderColor = UIColor.clear.cgColor
        self.m_captureBtn.layer.borderWidth = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SendIDViewController
        vc.m_captureImage = self.m_captureImage
    }
    
    
    func setupUI() {
        self.cameraViewInitialize()
    }
    
    func cameraViewInitialize() {
        self.m_containView.setupCameraView()
        self.m_containView.isBorderDetectionEnabled = false
        self.m_containView.cameraViewType = IPDFCameraViewType.normal
    }
    
    
    @IBAction func onCaptureBtn(_ sender: Any) {
        
        self.m_containView.captureImage { (captureImage) in
            
            DispatchQueue.main.async {
                let imgData = captureImage as? NSData
                self.m_captureImage = UIImage(data: (imgData! as Data))
                UIView.setAnimationsEnabled(false)
                self.performSegue(withIdentifier: "ToSendId", sender: nil)
                UIView.setAnimationsEnabled(true)
            }
        }
    }
}
