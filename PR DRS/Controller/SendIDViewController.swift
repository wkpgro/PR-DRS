//
//  SendIDViewController.swift
//  PR DRS
//
//  Created by Dusan on 5/2/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit

class SendIDViewController: UIViewController {

    var m_captureImage: UIImage?
    @IBOutlet weak var captureImgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.captureImgView.image = self.m_captureImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
